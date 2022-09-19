//
//  StringExtension.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import Foundation

extension String {
    func generationNumber() -> Int {
        if self == "Generation I" { return 1 }
        if self == "Generation II" { return 2 }
        if self == "Generation III" { return 3 }
        if self == "Generation IV" { return 4 }
        if self == "Generation V" { return 5 }
        if self == "Generation VI" { return 6 }
        if self == "Generation VII" { return 7 }
        if self == "Generation VIII" { return 8 }

        return -1
    }
}
