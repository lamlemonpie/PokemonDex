//
//  PokemonViewModel.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/14/22.
//

import Foundation
import Combine

final class PokemonViewModel: ObservableObject {
    private var client: PokemonProtocol
    private var networkMonitor: NetworkProtocol
    private var cancellables = Set<AnyCancellable>()
    private var restoredFromUserDefaults = false
    private var savedToUsedDefaults = false
    var networkStatusError = NetworkStatus.disconnected

    @Published var pokemonList: [Pokemon] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    var pokemonSections: [String: [Pokemon]] {
        Dictionary.init(grouping: pokemonList) { $0.generation }
    }

    @Published var isLoading = false
    @Published var isDetailsLoading = false
    @Published var hasNetworkStatusError = false
    @Published var hasError = false
    @Published var error: NetworkError?

    @Published var pokemonDescription: String?


    init(client: PokemonProtocol = PokemonClient(), networkMonitor: NetworkProtocol = NetworkMonitor()) {
        self.client = client
        self.networkMonitor = networkMonitor

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
                .dropFirst()
                .sink { pokemons in
                    self.pokemonList = pokemons
                }
                .store(in: &cancellables)
        }

        networkMonitor
            .statusPublisher
            .sink { status in
                self.hasNetworkStatusError = status == .disconnected
            }
            .store(in: &cancellables)
    }

    func allPokemon() {
        if !restoredFromUserDefaults && !savedToUsedDefaults {
            client.allPokemon()
        }
    }

    func getPokemonDescription(pokemonID: Int) {
        self.pokemonDescription = nil
        isDetailsLoading = true

        client
            .getPokemonDescription(pokemonID: pokemonID)
            .sink { [weak self] res in
                guard let self = self else { return }

                switch res {
                case .failure(let error):
                    self.hasError = true
                    self.error = .custom(error: error)
                default:
                    break
                }

                self.isDetailsLoading = false
            } receiveValue: { [weak self] receivedValue in
                guard let self = self else { return }

                let localizedFlavorTexts: [String] = receivedValue.flavorTextEntries?.compactMap { entry in
                    if entry.language.name == "en" {
                        return entry.flavorText.components(separatedBy: .newlines).joined(separator: " ")
                    } else {
                        return nil
                    }
                } ?? []

                let description = (localizedFlavorTexts.first != nil) ? localizedFlavorTexts.first : nil

                self.pokemonDescription = description
                self.isDetailsLoading = false
            }
            .store(in: &cancellables)
    }

    func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(pokemonList) {
            UserDefaults.standard.set(data, forKey: Constants.pokemonViewModelKey)
            savedToUsedDefaults = true
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
