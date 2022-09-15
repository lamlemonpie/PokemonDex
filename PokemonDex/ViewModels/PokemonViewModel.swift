//
//  PokemonViewModel.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/14/22.
//

import Foundation

final class PokemonViewModel: ObservableObject {
    var client: PokemonAPI

    @Published var pokemonList: [Pokemon] = []
    @Published var isLoading = false

    init(client: PokemonAPI = PokemonClient()) {
        self.client = client

        setBindings()
    }

    func setBindings() {
        client
            .isLoadingPublisher
            .assign(to: &$isLoading)

        client
            .pokemonsPublisher
            .assign(to: &$pokemonList)
    }

    func allPokemon() {
        client.allPokemon()
    }
}
