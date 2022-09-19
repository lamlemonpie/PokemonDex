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

    var body: some View {
        VStack(spacing: 0) {
            if let pokemon = pokemon {
                PokemonInfoHeaderView(pokemon: pokemon)

                PokemonInfoContentView(pokemon: pokemon)
            }
        }
        .navigationTitle("Pokemon Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(pokemon: Constants.pokemonDummy)
    }
}
