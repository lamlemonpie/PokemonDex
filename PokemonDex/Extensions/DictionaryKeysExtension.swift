//
//  DictionaryKeysExtension.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import Foundation

extension Dictionary where Key == String, Value == [Pokemon] {
    func generationSort() -> [String] {
        return self.keys.sorted { leftValue, rightValue in
            leftValue.generationNumber() < rightValue.generationNumber()
        }
    }
}
