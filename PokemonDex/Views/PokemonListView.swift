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
    @State var selectedPokemon: String = ""

    let pokemons = ["Bulbasaur", "Charmander"]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(pokemons, id: \.self) { pokemon in
                        PokemonCellView(pokemon: pokemon)
                            .onTapGesture {
                                selectedPokemon = pokemon
                                isCellClicked = true
                            }
                    }
                    .padding(.init(top: 12.0, leading: 24.0, bottom: 0.0, trailing: 24.0))
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
            .navigationTitle("Pokemon List")
            .navigationBar(backgroundColor: Color("PokemonHeaderBackground"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    var searchResults: [String] {
        if searchString.isEmpty {
            return []
        } else {
            return pokemons.filter { $0.contains(searchString) }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
