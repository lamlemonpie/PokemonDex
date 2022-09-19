//
//  PokemonColors.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/17/22.
//

import SwiftUI

enum PokemonColors: String, CaseIterable {
    case black
    case blue
    case brown
    case gray
    case green
    case pink
    case purple
    case red
    case white
    case yellow

    var colorValue: Color {
        switch self {
        case .black:
            return Color("PokemonColorBlack")
        case .blue:
            return Color("PokemonColorBlue")
        case .brown:
            return Color("PokemonColorBrown")
        case .gray:
            return Color("PokemonColorGray")
        case .green:
            return Color("PokemonColorGreen")
        case .pink:
            return Color("PokemonColorPink")
        case .purple:
            return Color("PokemonColorPurple")
        case .red:
            return Color("PokemonColorRed")
        case .white:
            return Color("PokemonColorWhite")
        case .yellow:
            return Color("PokemonColorYellow")
        }
    }
}
