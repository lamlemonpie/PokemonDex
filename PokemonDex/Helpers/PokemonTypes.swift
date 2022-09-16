//
//  PokemonTypes.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/15/22.
//

import Foundation
import SwiftUI

enum PokemonTypes: String, CaseIterable {
    case bug
    case dark
    case dragon
    case electric
    case fairy
    case fighting
    case fire
    case flying
    case ghost
    case grass
    case ground
    case ice
    case normal
    case poison
    case psychic
    case rock
    case steel
    case water

    var displayName: String {
        rawValue.capitalized
    }


    var image: Image {
        switch self {
        case .bug:
            return Image("BugType")
        case .dark:
            return Image("DarkType")
        case .dragon:
            return Image("DragonType")
        case .electric:
            return Image("ElectricType")
        case .fairy:
            return Image("FairyType")
        case .fighting:
            return Image("FightType")
        case .fire:
            return Image("FireType")
        case .flying:
            return Image("FlyingType")
        case .ghost:
            return Image("GhostType")
        case .grass:
            return Image("GrassType")
        case .ground:
            return Image("GroundType")
        case .ice:
            return Image("IceType")
        case .normal:
            return Image("NormalType")
        case .poison:
            return Image("PoisonType")
        case .psychic:
            return Image("PsychicType")
        case .rock:
            return Image("RockType")
        case .steel:
            return Image("SteelType")
        case .water:
            return Image("WaterType")
        }
    }
}
