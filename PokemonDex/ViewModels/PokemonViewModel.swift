//
//  PokemonViewModel.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/14/22.
//

import Foundation
import Combine

final class PokemonViewModel: ObservableObject {
    private var client: PokemonAPI
    private var cancellables = Set<AnyCancellable>()
    private var restoredFromUserDefaults = false

    @Published var pokemonList: [Pokemon] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    @Published var isLoading = false

    init(client: PokemonAPI = PokemonClient()) {
        self.client = client

        restoreFromUserDefaults()

        setBindings()
    }

    func setBindings() {
        if !restoredFromUserDefaults {
            client
                .isLoadingPublisher
                .assign(to: &$isLoading)

            client
                .pokemonsPublisher
                .sink { pokemons in
                    self.pokemonList = pokemons
                }
                .store(in: &cancellables)
        }
    }

    func allPokemon() {
        if !restoredFromUserDefaults {
            client.allPokemon()
        }
    }


    func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(pokemonList) {
            UserDefaults.standard.set(data, forKey: Constants.pokemonViewModelKey)
        }
    }

    func restoreFromUserDefaults() {
        let decoder = JSONDecoder()
        if  let data = UserDefaults.standard.data(forKey: Constants.pokemonViewModelKey),
            let decodedPokemons = try? decoder.decode([Pokemon].self, from: data) {
            pokemonList = decodedPokemons
            restoredFromUserDefaults = true
        }
    }
}
