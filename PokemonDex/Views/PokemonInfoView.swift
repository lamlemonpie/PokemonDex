//
//  PokemonInfoView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/12/22.
//

import SwiftUI

struct PokemonInfoView: View {
    let pokemon: Pokemon?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("Info for: \(pokemon?.name ?? "Name")")
                Spacer()
            }
            .navigationTitle("Pokemon info")
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(pokemon: Pokemon(
            id: 0,
            name: "Bulbasaur",
            generation: "I",
            types: nil,
            sprites: PokemonSprite(frontDefault: "")))
    }
}
