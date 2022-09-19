//
//  PokemonInfoContentView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/17/22.
//

import SwiftUI

struct PokemonInfoContentView: View {
    let pokemon: Pokemon
    @EnvironmentObject var pokemonViewModel: PokemonViewModel

    var pokemonBackgroundColor: Color {
        guard let pokemonColor = pokemon.colorValue else { return .white }

        return pokemonColor
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(pokemonBackgroundColor)
                .frame(maxWidth: .infinity)

            VStack {
                Text(String(format: "#%03d \(pokemon.name.capitalized)", pokemon.id))
                    .font(.title)
                    .padding(.top, 16.0)

                HStack {
                    ForEach(pokemon.types, id: \.id) { type in
                        type
                            . tagImage?
                            .padding(.horizontal, 9.0)
                    }
                }

                Text(pokemon.generation)
                    .padding(.top, 21.0)

                if pokemonViewModel.isDetailsLoading {
                    ProgressView()
                        .padding(16.0)
                } else {
                    if let description = pokemonViewModel.pokemonDescription {
                        Text(description)
                            .font(.footnote)
                            .padding(16.0)
                    } else {
                        Text("Description not available")
                            .font(.footnote)
                            .padding(16.0)
                    }
                }

                if !(pokemon.evolutions?.isEmpty ?? true) {
                    Divider()

                    PokemonInfoEvolutionsView(pokemon: pokemon)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color("PokemonDetailsBackground"))
            .cornerRadius(32.0, corners: [.topLeft, .topRight])
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct PokemonInfoContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoContentView(pokemon: Constants.pokemonDummy)
    }
}
