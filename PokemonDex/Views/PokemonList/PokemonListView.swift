//
//  PokemonListView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/12/22.
//

import SwiftUI

struct PokemonListView: View {
    @State var searchString: String = ""
    @State var isCellClicked = false
    @State var selectedPokemon: Pokemon?
    @State var currentGeneration = "Generation I"

    @StateObject var pokemonViewModel = PokemonViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if pokemonViewModel.isLoading {
                    ProgressView()
                } else if pokemonViewModel.hasNetworkStatusError {
                    Image("NetworkLost").resizable().frame(width: 160.0, height: 160.0)
                } else {
                    ScrollView {
                        PokemonListSectionsView(
                            pokemonSections: pokemonViewModel.pokemonSections,
                            onTapFuncion: onTapFunction
                        )

                        NavigationLink(
                            destination: PokemonInfoView(pokemon: selectedPokemon),
                            isActive: $isCellClicked) {
                            EmptyView()
                        }
                        .isDetailLink(false)
                        .opacity(0)
                    }
                    .searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .automatic)) {
                        PokemonListSearchView(searchResults: searchResults, onTapFuncion: onTapFunction)
                    }
                }
            }
            .alert(isPresented: $pokemonViewModel.hasNetworkStatusError, error: pokemonViewModel.networkStatusError) {
                Button(
                    action: { pokemonViewModel.allPokemon() },
                    label: {
                        Text("Try Again")
                    }
                )
                Button(
                    action: { },
                    label: {
                        Text("Cancel")
                    }
                )
            }
            .onAppear {
                pokemonViewModel.allPokemon()
            }
            .navigationTitle("Pokemon List")
            .navigationBar(backgroundColor: Color("PokemonHeaderBackground"))
        }
        .navigationViewStyle(.stack)
        .environmentObject(pokemonViewModel)
    }


    var searchResults: [String: [Pokemon]] {
        if searchString.isEmpty {
            return [:]
        } else {
            let results = pokemonViewModel.pokemonList.filter { $0.name.contains(searchString.lowercased()) }
            return Dictionary.init(grouping: results) { $0.generation }
        }
    }

    func onTapFunction(pokemon: Pokemon) {
        selectedPokemon = pokemon

        pokemonViewModel.getPokemonDescription(pokemonID: pokemon.id)
        isCellClicked = true
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
