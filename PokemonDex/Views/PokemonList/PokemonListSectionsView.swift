//
//  PokemonListSectionsView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import SwiftUI

struct PokemonListSectionsView: View {
    let pokemonSections: [String: [Pokemon]]
    let onTapFuncion: (_ pokemon: Pokemon) -> Void

    var sortedGenerationKeys: [String] {
        return pokemonSections.generationSort()
    }

    var body: some View {
        ForEach(sortedGenerationKeys, id: \.self) { generation in
            HStack(alignment: .center) {
                Text(generation)

                Spacer()
            }
            .padding(.init(top: 24.0, leading: 24.0, bottom: 0.0, trailing: 24.0))

            Divider()
                .padding(.init(top: 0.0, leading: 24.0, bottom: 16.0, trailing: 24.0))

            ForEach(pokemonSections[generation] ?? [], id: \.id) { pokemon in
                PokemonCellView(pokemon: pokemon)
                    .onTapGesture {
                        onTapFuncion(pokemon)
                    }
            }
            .padding(.init(top: 0.0, leading: 24.0, bottom: 12.0, trailing: 24.0))
            .listRowSeparator(.hidden)
        }
    }
}
