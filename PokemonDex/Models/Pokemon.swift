//
//  Pokemon.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/14/22.
//

import Foundation

struct Pokemon: Identifiable, Hashable {
    let id: Int
    let name: String?
    let generation: String?
    let types: [PokemonType]?
    let sprites: PokemonSprite?
}
