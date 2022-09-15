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
                if let pokemons = queryData.data?.allPokemon {
                    let compactedPokemons = pokemons.compactMap { $0 }
                    let newPokemons: [Pokemon?] = compactedPokemons.map { pokemon in
                        guard let id = pokemon.id else { return nil }
                        guard let types = pokemon.types else { return nil }
                        let compactedTypes = types.compactMap { $0 }
                        guard let frontDefault: String = pokemon.sprites?.frontDefault else { return nil }
                        let sprites = PokemonSprite(frontDefault: frontDefault)

                        return Pokemon(
                            id: id,
                            name: pokemon.name,
                            generation: pokemon.generation,
                            types: nil,
                            sprites: sprites
                        )
                    }

                    self.pokemons = newPokemons.compactMap { $0 }
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
