//
//  TestError.swift
//  PokemonDexTests
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import Foundation

enum TestError: Error, Equatable {
    case invalidSetUpTest
    case unexpectedBehavior
}
