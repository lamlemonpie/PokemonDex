//
//  Constants.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/14/22.
//

import Foundation

enum Constants {
    static let apolloURL = "https://dex-server.herokuapp.com/"
    static let restURL = "https://pokeapi.co/api/v2/pokemon-species/"

    static let pokemonViewModelKey = "pokemonViewModel"

    static let pokemonDummy = Pokemon(
        id: 1,
        name: "Bulbasaur",
        color: "green",
        generation: "Generation I",
        types: [PokemonType(id: 1, name: "Grass"), PokemonType(id: 2, name: "Poison")],
        sprites: PokemonSprite(
            frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"
        ),
        evolutions: [
            PokemonEvolution(
            id: 2,
            name: "ivysaur",
            sprites: PokemonSprite(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png",
                frontShiny: "")
            )
        ]
    )
}
