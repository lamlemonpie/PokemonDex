//
//  PokemonClient.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/14/22.
//

import Foundation
import Apollo
import Combine

final class PokemonClient: PokemonProtocol, ObservableObject {
    var session: URLSession
    static var shared = PokemonClient()
    private(set) var apolloClient: ApolloClientProtocol?
    @Published var error: Error?

    @Published var pokemons: [Pokemon] = []
    var pokemonsPublished: Published<[Pokemon]> { _pokemons }
    var pokemonsPublisher: Published<[Pokemon]>.Publisher { $pokemons }

    @Published var isLoading = false
    var isLoadingPublished: Published<Bool> { _isLoading }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }

    @Published var pokemonDescription = ""

    init(apolloURL: String = Constants.apolloURL, apollo: ApolloClientProtocol? = nil, session: URLSession = .shared) {
        self.session = session

        if let apolloClient = apollo {
            self.apolloClient = apolloClient
        } else {
            guard let url = URL(string: apolloURL) else { return }
            self.apolloClient = ApolloClient(url: url)
        }
    }

    func allPokemon() {
        guard let apollo = apolloClient else { return }

        isLoading = true

        _ = apollo.fetch(
            query: AllPokemonQuery(),
            cachePolicy: .returnCacheDataElseFetch,
            contextIdentifier: nil,
            queue: .main
        ) { [weak self] result in
            guard let self = self else { return }
            print("res: \(result)")
            switch result {
            case .success(let queryData):
                self.unwrapPokemons(of: queryData)
            case .failure(let queryError):
                self.error = queryError
                print("Error: \(queryError.localizedDescription)")
            }

            self.isLoading = false
        }
    }

    func unwrapPokemons(of queryData: GraphQLResult<AllPokemonQuery.Data>) {
        if let pokemons = queryData.data?.allPokemon?.compactMap({ $0 }) {
            let newPokemons: [Pokemon] = pokemons.compactMap { pokemon in
                guard
                    let id = pokemon.id,
                    let name = pokemon.name,
                    let color = pokemon.color,
                    let generation = pokemon.generation,
                    let types = pokemon.types?.compactMap({ $0 }),
                    let frontDefault = pokemon.sprites?.frontDefault,
                    let frontShiny = pokemon.sprites?.frontShiny
                else {
                    return nil
                }

                let newTypes: [PokemonType] = types.map { type in
                    guard let typeID = type.id, let typeName = type.name else { return nil }
                    return PokemonType(id: typeID, name: typeName)
                }
                .compactMap { $0 }

                var newEvolutions: [PokemonEvolution]?
                if let evolutions = pokemon.evolvesTo?.compactMap({ $0 }) {
                    let mappedEvolutions: [PokemonEvolution?] = evolutions.map { evol in
                        guard
                            let evolID = evol.id,
                            let name = evol.name,
                            let frontSprinte = evol.sprites?.frontDefault
                        else { return nil }

                        return PokemonEvolution(
                            id: evolID,
                            name: name,
                            sprites: PokemonSprite(frontDefault: frontSprinte, frontShiny: "")
                        )
                    }

                    newEvolutions = mappedEvolutions.compactMap { $0 }
                }

                return Pokemon(
                    id: id,
                    name: name,
                    color: color,
                    generation: generation,
                    types: newTypes,
                    sprites: PokemonSprite(frontDefault: frontDefault, frontShiny: frontShiny),
                    evolutions: newEvolutions
                )
            }

            self.pokemons = newPokemons
        }
    }

    func getPokemonDescription(pokemonID: Int) -> AnyPublisher<PokemonSpecies, Error> {
        guard let url = URL(string: Constants.restURL + String(pokemonID)) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        return session
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { res -> PokemonSpecies in
                if  let response = res.response as? HTTPURLResponse,
                    response.statusCode < 200 || response.statusCode >= 300 {
                    throw NetworkError.invalidStatusCode(code: response.statusCode)
                }

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                guard let dataResponse = try? decoder.decode(PokemonSpecies.self, from: res.data) else {
                    print("decoding error")
                    throw NetworkError.failedToDecode
                }

                return dataResponse
            }
            .eraseToAnyPublisher()
    }
}
