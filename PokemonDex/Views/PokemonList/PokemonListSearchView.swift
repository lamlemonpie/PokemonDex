//
//  PokemonListSearchView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import SwiftUI

struct PokemonListSearchView: View {
    var searchResults: [String: [Pokemon]]
    let onTapFuncion: (_ pokemon: Pokemon) -> Void

    var sortedGenerationKeys: [String] {
        return searchResults.generationSort()
    }

    var body: some View {
        ForEach(sortedGenerationKeys, id: \.self) { generation in
            HStack(alignment: .center) {
                Text(generation)

                Spacer()
            }
            .padding(.init(top: 16.0, leading: 4.0, bottom: 0.0, trailing: 4.0))

            Divider()
                .padding(.init(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 4.0))

            ForEach(searchResults[generation] ?? [], id: \.id) { pokemon in
                PokemonCellView(pokemon: pokemon)
                    .onTapGesture {
                        onTapFuncion(pokemon)
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listRowSeparator(.hidden)
    }
}
