//
//  NetworkProtocol.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import Foundation

protocol NetworkProtocol {
    var status: NetworkStatus { get }
    var statusPublished: Published<NetworkStatus> { get }
    var statusPublisher: Published<NetworkStatus>.Publisher { get }
}
