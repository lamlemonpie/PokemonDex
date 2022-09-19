//
//  PokemonInfoHeaderView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/17/22.
//

import SwiftUI
import Kingfisher

struct PokemonInfoHeaderView: View {
    let pokemon: Pokemon
    @State var selectedPokemonVariation: String = PokemonVariations.normal.rawValue

    var selectedVariationImage: String {
        if selectedPokemonVariation == PokemonVariations.normal.rawValue {
            return pokemon.sprites.frontDefault
        } else {
            return pokemon.sprites.frontShiny
        }
    }

    var pokemonBackgroundColor: Color {
        guard let pokemonColor = pokemon.colorValue else { return .white }

        return pokemonColor
    }

    var body: some View {
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
    }
}

struct PokemonInfoHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoHeaderView(pokemon: Constants.pokemonDummy)
    }
}
