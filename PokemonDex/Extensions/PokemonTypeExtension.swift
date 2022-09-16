//
//  PokemonTypeExtension.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/15/22.
//

import SwiftUI

extension PokemonType {
    var image: Image? {
        var image: Image?
        PokemonTypes.allCases.forEach { type in
            if type.displayName == name {
                image = type.image
            }
        }

        return image
    }
}
