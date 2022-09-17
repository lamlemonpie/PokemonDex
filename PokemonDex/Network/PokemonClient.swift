//
//  PokemonClient.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/14/22.
//

import Foundation
import Apollo
import Combine

final class PokemonClient: PokemonAPI, ObservableObject {
    static var shared = PokemonClient()
    private(set) var apollo: ApolloClient?

    @Published var pokemons: [Pokemon] = []
    var pokemonsPublished: Published<[Pokemon]> { _pokemons }
    var pokemonsPublisher: Published<[Pokemon]>.Publisher { $pokemons }

    @Published var isLoading = false
    var isLoadingPublished: Published<Bool> { _isLoading }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }

    init(apolloURL: String = Constants.apolloURL) {
        guard let url = URL(string: apolloURL) else { return }

        self.apollo = ApolloClient(url: url)
    }

    func allPokemon() {
        guard let apollo = apollo else { return }

        isLoading = true

        apollo.fetch(query: AllPokemonQuery()) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let queryData):
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

                        let newTypes: [PokemonType] = types
                            .map { type in
                                guard let typeID = type.id, let typeName = type.name else { return nil }
                                return PokemonType(id: typeID, name: typeName)
                            }
                            .compactMap { $0 }

                        return Pokemon(
                            id: id,
                            name: name,
                            color: color,
                            generation: generation,
                            types: newTypes,
                            sprites: PokemonSprite(frontDefault: frontDefault, frontShiny: frontShiny)
                        )
                    }

                    self.pokemons = newPokemons
                }
            case .failure(let queryError):
                print("Error: \(queryError.localizedDescription)")
            }

            self.isLoading = false
        }
    }

    func pokemonDetail() {
    }
}
