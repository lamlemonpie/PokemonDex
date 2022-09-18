//
//  Pokemon.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/14/22.
//

import Foundation

struct Pokemon: Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let color: String
    let generation: String
    let types: [PokemonType]
    let sprites: PokemonSprite
    let evolutions: [PokemonEvolution]?
}
