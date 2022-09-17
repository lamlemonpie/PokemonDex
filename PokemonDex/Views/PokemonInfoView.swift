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
        if let pokemon = pokemon {
            if selectedPokemonVariation == PokemonVariations.normal.rawValue {
                return pokemon.sprites.frontDefault
            } else {
                return pokemon.sprites.frontShiny
            }
        }

        return ""
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
                .background(.green)


                ZStack {
                    Rectangle()
                        .fill(.green)
                        .frame(maxWidth: .infinity)

                    VStack {
                        Text(String(format: "#%03d \(pokemon.name)", pokemon.id))

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(32.0, corners: [.topLeft, .topRight])
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
            generation: "Generation I",
            types: [PokemonType(id: 1, name: "Grass"), PokemonType(id: 1, name: "Poison")],
            sprites: PokemonSprite(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"
            )))
    }
}
