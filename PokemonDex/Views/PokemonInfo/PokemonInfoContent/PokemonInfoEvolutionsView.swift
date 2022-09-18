//
//  PokemonInfoEvolutionsView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/17/22.
//

import SwiftUI

struct PokemonInfoEvolutionsView: View {
    let pokemon: Pokemon

    var body: some View {
        ScrollView {
            if let evolutions = pokemon.evolutions {
                Text("Evolutions")
                    .font(.title3)
                    .fontWeight(.regular)

                VStack {
                    ForEach(evolutions, id: \.id) { evolution in
                        HStack(alignment: .center) {
                            Spacer()

                            PokemonSmallView(pokemon: pokemon)

                            Image("ArrowDown")
                                .resizable()
                                .frame(width: 24.0, height: 24.0)

                            PokemonSmallView(pokemon: Pokemon(
                                id: evolution.id,
                                name: evolution.name,
                                color: "",
                                generation: "",
                                types: [],
                                sprites: PokemonSprite(
                                    frontDefault: evolution.sprites.frontDefault,
                                    frontShiny: evolution.sprites.frontShiny),
                                evolutions: nil)
                            )

                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct PokemonInfoEvolutionsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoEvolutionsView(pokemon: Constants.pokemonDummy)
    }
}
