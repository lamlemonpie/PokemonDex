//
//  PokemonProtocol.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/14/22.
//

import Foundation
import Combine

protocol PokemonProtocol {
    var isLoading: Bool { get set }
    // (Published property wrapper)
    var isLoadingPublished: Published<Bool> { get }
    // Publisher
    var isLoadingPublisher: Published<Bool>.Publisher { get }

    var pokemons: [Pokemon] { get }
    // (Published property wrapper)
    var pokemonsPublished: Published<[Pokemon]> { get }
    // Publisher
    var pokemonsPublisher: Published<[Pokemon]>.Publisher { get }

    func allPokemon()

    // REST Endpoint variables
    var session: URLSession { get }
    var pokemonDescription: String { get }
    func getPokemonDescription(pokemonID: Int) -> AnyPublisher<PokemonSpecies, Error>
}
