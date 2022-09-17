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

    let rectangle: some View = RoundedRectangle(cornerRadius: 16.0)
        .fill(Color("PokemonCell"))
        .padding(.leading, 24.0)
        .frame(maxWidth: .infinity, minHeight: 80.0, maxHeight: 80.0)

    var body: some View {
        HStack(alignment: .center) {
            KFImage(URL(string: pokemon.sprites.frontDefault))
                .placeholder { ProgressView() }
                .downsampling(size: CGSize(width: 72.0, height: 72.0))
                .aspectRatio(contentMode: .fill)

            Spacer(minLength: 16.0)

            VStack(alignment: .trailing) {
                Text(pokemon.name.capitalized)
                    .fontWeight(.semibold)
                    .frame(width: 134.0, alignment: .leading)

                Text(String(format: "#%03d", pokemon.id))
                    .frame(width: 134.0, alignment: .leading)
            }

            Spacer(minLength: 14.0)

            HStack {
                ForEach(pokemon.types, id: \.id) { type in
                    type
                        .typeImage?
                        .frame(width: 30.0, height: 30.0)
                        .padding(.trailing, 10.0)
                }
            }
            .frame(minWidth: 80.0)
            .padding(.trailing, 11.0)
        }
        .frame(maxWidth: .infinity, minHeight: 80.0, maxHeight: 80.0)
        .background(rectangle)
        .cornerRadius(16.0)
    }
}

struct PokemonCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCellView(pokemon: Pokemon(
            id: 1,
            name: "Bulbasaur",
            color: "green",
            generation: "Generation I",
            types: [PokemonType(id: 1, name: "Grass"), PokemonType(id: 1, name: "Poison")],
            sprites: PokemonSprite(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"
            )))
    }
}
