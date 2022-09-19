//
//  NetworkStatus.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import Foundation

enum NetworkStatus: LocalizedError {
    case connected
    case disconnected

    var errorDescription: String? {
        switch self {
        case .disconnected:
            return "There is a problem trying to connect. Please check your connectivity"
        default:
            return nil
        }
    }
}
