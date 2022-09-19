//
//  PokemonEvolution.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/17/22.
//

import Foundation

struct PokemonEvolution: Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let sprites: PokemonSprite
}
