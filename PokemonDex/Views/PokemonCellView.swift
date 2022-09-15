//
//  PokemonCellView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/12/22.
//

import SwiftUI
import Kingfisher

struct PokemonCellView: View {
    let pokemon: Pokemon

    let rectangle: some View = RoundedRectangle(cornerRadius: 16)
        .fill(Color("PokemonCell"))
        .padding(.leading, 24.0)
        .frame(maxWidth: .infinity, minHeight: 80.0)

    var body: some View {
        HStack {
            KFImage(URL(string: pokemon.sprites?.frontDefault ?? ""))
                .placeholder { ProgressView() }
                .downsampling(size: CGSize(width: 72.0, height: 72.0))
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading) {
                Text("\(pokemon.name?.capitalized ?? "Name")")
                    .fontWeight(.semibold)

                Text(String(format: "#%03d", pokemon.id))
            }
            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 14.0))

            HStack {
                Text("X").frame(width: 30.0, height: 30.0)
                Text("Y").frame(width: 30.0, height: 30.0)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 80.0)
        .background(rectangle)
        .cornerRadius(16)
    }
}

struct PokemonCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCellView(pokemon: Pokemon(
            id: 0,
            name: "Bulbasaur",
            generation: "I",
            types: nil,
            sprites: nil))
    }
}
