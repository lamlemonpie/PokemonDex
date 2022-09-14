//
//  PokemonInfoView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/12/22.
//

import SwiftUI

struct PokemonInfoView: View {
    let pokemon: String

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("Info for: \(pokemon)")
                Spacer()
            }
            .navigationTitle("Pokemon info")
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(pokemon: "Bulbasaur")
    }
}
