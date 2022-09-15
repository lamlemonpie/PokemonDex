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

    @StateObject var pokemonViewModel = PokemonViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if pokemonViewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        HStack(alignment: .center) {
                            Text("Generation I")

                            Spacer()
                        }
                        .padding(.init(top: 24.0, leading: 24.0, bottom: 0.0, trailing: 24.0))

                        Divider()
                            .padding(.init(top: 0.0, leading: 24.0, bottom: 16.0, trailing: 24.0))

                        ForEach(pokemonViewModel.pokemonList, id: \.id) { pokemon in
                            PokemonCellView(pokemon: pokemon)
                                .onTapGesture {
                                    selectedPokemon = pokemon
                                    isCellClicked = true
                                }
                        }
                        .padding(.init(top: 0.0, leading: 24.0, bottom: 12.0, trailing: 24.0))
                        .listRowSeparator(.hidden)

                        NavigationLink(
                            destination: PokemonInfoView(pokemon: selectedPokemon),
                            isActive: $isCellClicked) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                    .searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .automatic)) {
                        ForEach(searchResults, id: \.self) { result in
                            PokemonCellView(pokemon: result)
                        }
                    }
                }
            }
            .onAppear {
                pokemonViewModel.allPokemon()
            }
            .navigationTitle("Pokemon List")
            .navigationBar(backgroundColor: Color("PokemonHeaderBackground"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    var searchResults: [Pokemon] {
        if searchString.isEmpty {
            return []
        } else {
            return pokemonViewModel.pokemonList.filter { $0.name?.contains(searchString) ?? false }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
