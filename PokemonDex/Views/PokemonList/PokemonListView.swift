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

    func generationNumber(_ generation: String) -> Int {
        if generation == "Generation I" { return 1 }
        if generation == "Generation II" { return 2 }
        if generation == "Generation III" { return 3 }
        if generation == "Generation IV" { return 4 }
        if generation == "Generation V" { return 5 }
        if generation == "Generation VI" { return 6 }
        if generation == "Generation VII" { return 7 }
        if generation == "Generation VIII" { return 8 }

        return -1
    }

    var sortedGenerationKeys: [String] {
        let keys = pokemonViewModel.pokemonSections.keys
        return keys.sorted { leftValue, rightValue in
            generationNumber(leftValue) < generationNumber(rightValue)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                if pokemonViewModel.isLoading {
                    ProgressView()
                } else if pokemonViewModel.hasNetworkStatusError {
                    Image("NetworkLost").resizable().frame(width: 160.0, height: 160.0)
                } else {
                    ScrollView {
                        ForEach(Array(sortedGenerationKeys), id: \.self) { generation in
                            HStack(alignment: .center) {
                                Text(generation)

                                Spacer()
                            }
                            .padding(.init(top: 24.0, leading: 24.0, bottom: 0.0, trailing: 24.0))

                            Divider()
                                .padding(.init(top: 0.0, leading: 24.0, bottom: 16.0, trailing: 24.0))

                            ForEach(pokemonViewModel.pokemonSections[generation] ?? [], id: \.id) { pokemon in
                                PokemonCellView(pokemon: pokemon)
                                    .onTapGesture {
                                        selectedPokemon = pokemon

                                        pokemonViewModel.getPokemonDescription(pokemonID: pokemon.id)
                                        isCellClicked = true
                                    }
                            }
                            .padding(.init(top: 0.0, leading: 24.0, bottom: 12.0, trailing: 24.0))
                            .listRowSeparator(.hidden)
                        }

                        NavigationLink(
                            destination: PokemonInfoView(pokemon: selectedPokemon),
                            isActive: $isCellClicked) {
                            EmptyView()
                        }
                        .isDetailLink(false)
                        .opacity(0)
                    }
                    .searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .automatic)) {
                        ForEach(searchResults, id: \.self) { result in
                            PokemonCellView(pokemon: result)
                                .onTapGesture {
                                    selectedPokemon = result
                                    isCellClicked = true
                                }
                        }
                        .listRowSeparator(.hidden)
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

    var searchResults: [Pokemon] {
        if searchString.isEmpty {
            return []
        } else {
            return pokemonViewModel.pokemonList.filter { $0.name.contains(searchString.lowercased()) }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
