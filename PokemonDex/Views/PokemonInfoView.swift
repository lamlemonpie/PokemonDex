//
//  PokemonInfoView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/12/22.
//

import SwiftUI
import Kingfisher

struct PokemonInfoView: View {
    let pokemon: Pokemon?
    @State var selectedPokemonVariation: String = PokemonVariations.normal.rawValue

    var selectedVariationImage: String {
        guard let pokemon = pokemon else { return "" }

        if selectedPokemonVariation == PokemonVariations.normal.rawValue {
            return pokemon.sprites.frontDefault
        } else {
            return pokemon.sprites.frontShiny
        }
    }

    var pokemonBackgroundColor: Color {
        guard let pokemon = pokemon, let pokemonColor = pokemon.colorValue else { return .white }

        return pokemonColor
    }

    var body: some View {
        VStack(spacing: 0) {
            if let pokemon = pokemon {
                VStack {
                    KFImage(URL(string: selectedVariationImage))
                        .placeholder { ProgressView().frame(width: 158.4, height: 158.4) }
                        .resizing(referenceSize: CGSize(width: 158.4, height: 158.4))

                    Picker("Pokemon Variation", selection: $selectedPokemonVariation) {
                        ForEach(PokemonVariations.allCases, id: \.self) {
                            Text($0.rawValue).tag($0.rawValue)
                        }
                    }
                    .padding(.horizontal, 18.0)
                    .pickerStyle(.segmented)
                }
                .frame(maxWidth: .infinity, minHeight: 256.0)
                .background(pokemonBackgroundColor)


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
                            .padding(.init(top: 21.0, leading: 0.0, bottom: 16.0, trailing: 0.0))

                        Text("This is the pokemon description")

                        Divider()

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("PokemonDetailsBackground"))
                    .cornerRadius(32.0, corners: [.topLeft, .topRight])
                    .ignoresSafeArea(edges: .bottom)
                }
            }
        }
        .navigationTitle("Pokemon Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(pokemon: Pokemon(
            id: 1,
            name: "Bulbasaur",
            color: "green",
            generation: "Generation I",
            types: [PokemonType(id: 1, name: "Grass"), PokemonType(id: 2, name: "Poison")],
            sprites: PokemonSprite(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"
            )))
    }
}
