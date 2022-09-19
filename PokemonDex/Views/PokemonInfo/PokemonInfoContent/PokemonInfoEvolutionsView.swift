//
//  PokemonInfoEvolutionsView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/17/22.
//

import SwiftUI

struct PokemonInfoEvolutionsView: View {
    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    let pokemon: Pokemon

    var body: some View {
        VStack {
            if let evolutions = pokemon.evolutions {
                Text("Evolutions")
                    .font(.title3)
                    .fontWeight(.regular)

                ScrollView {
                    ForEach(evolutions, id: \.id) { evolution in
                        let evolutionPokemon: Pokemon? = pokemonViewModel.pokemonList.first { poke in
                            poke.id == evolution.id && poke.name == evolution.name
                        }

                        HStack(alignment: .center) {
                            Spacer()

                            PokemonSmallView(pokemon: pokemon, isActive: false)

                            Image("ArrowDown")
                                .resizable()
                                .frame(width: 24.0, height: 24.0)
                                .padding(.horizontal, 20.0)

                            if let evolutionPokemon = evolutionPokemon {
                                PokemonSmallView(pokemon: evolutionPokemon)
                            } else {
                                PokemonSmallView(
                                    pokemon: Pokemon(
                                    id: evolution.id,
                                    name: evolution.name,
                                    color: "",
                                    generation: "",
                                    types: [],
                                    sprites: PokemonSprite(
                                        frontDefault: evolution.sprites.frontDefault,
                                        frontShiny: evolution.sprites.frontShiny),
                                    evolutions: nil),
                                    isActive: false
                                )
                            }

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
