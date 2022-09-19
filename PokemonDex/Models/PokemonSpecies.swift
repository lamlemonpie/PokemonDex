//
//  PokemonSpecies.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import Foundation

struct PokemonSpecies: Codable {
    let id: Int
    let name: String
    let order: Int
    let genderRate: Int
    let captureRate: Int
    let baseHappiness: Int
    let isBaby: Bool
    let isLegendary: Bool
    let isMythical: Bool
    let hatchCounter: Int
    let hasGenderDifferences: Bool
    let formsSwitchable: Bool
    let growthRate: GrowthRate
    let pokedexNumbers: [PokedexNumber]
    let eggGroups: [EggGroup]?
    let color: PokemonColor
    let shape: PokemonShape?
    let evolvesFromSpecies: EvolvesFromSpecies?
    let evolutionChain: EvolutionChain?
    let habitat: Habitat?
    let generation: Generation
    let names: [PokemonName]?
    let palParkEncounters: [PalParkEncounter]?
    let flavorTextEntries: [FlavorTextEntry]?
    let formDescriptions: [FormDescription]?
    let genera: [Genera]?
    let varieties: [Variety]?
}

struct GrowthRate: Codable {
    let name: String
    let url: String
}

struct PokedexNumber: Codable {
    let entryNumber: Int
    let pokedex: Pokedex

    struct Pokedex: Codable {
        let name: String
        let url: String
    }
}

struct EggGroup: Codable {
    let name: String
    let url: String
}

struct PokemonColor: Codable {
    let name: String
    let url: String
}

struct PokemonShape: Codable {
    let name: String
    let url: String
}

struct EvolvesFromSpecies: Codable {
    let name: String
    let url: String
}

struct EvolutionChain: Codable {
    let url: String
}

struct Habitat: Codable {
    let name: String
    let url: String
}

struct Generation: Codable {
    let name: String
    let url: String
}

struct PokemonName: Codable {
    let name: String
    let language: Language

    struct Language: Codable {
        let name: String
        let url: String
    }
}

struct PalParkEncounter: Codable {
    let baseScore: Int
    let rate: Int
    let area: Area

    struct Area: Codable {
        let name: String
        let url: String
    }
}

struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: Language
    let version: Version

    struct Language: Codable {
        let name: String
        let url: String
    }

    struct Version: Codable {
        let name: String
        let url: String
    }
}

struct FormDescription: Codable {
    let description: String
    let language: Language

    struct Language: Codable {
        let name: String
        let url: String
    }
}

struct Genera: Codable {
    let genus: String
    let language: Language

    struct Language: Codable {
        let name: String
        let url: String
    }
}

struct Variety: Codable {
    let isDefault: Bool
    let pokemon: PokemonDetail

    struct PokemonDetail: Codable {
        let name: String
        let url: String
    }
}
