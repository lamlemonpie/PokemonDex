//
//  PokemonExtension.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/17/22.
//

import SwiftUI

extension Pokemon {
    var colorValue: Color? {
        var colorVal: Color?
        PokemonColors.allCases.forEach { col in
            if color == col.rawValue {
                colorVal = col.colorValue
            }
        }

        return colorVal
    }
}
