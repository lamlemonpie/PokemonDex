//
//  NetworkError.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case custom(error: Error)
    case failedToDecode
    case invalidURL
    case invalidStatusCode(code: Int)

    var errorDescription: String? {
        switch self {
        case .failedToDecode:
            return "Failed to decode"
        case .invalidURL:
            return "Invalid URL"
        case .custom(let error):
            return error.localizedDescription
        case .invalidStatusCode(let code):
            return "Invalid request: status \(code)"
        }
    }
}
