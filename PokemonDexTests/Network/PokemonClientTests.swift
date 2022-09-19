//
//  PokemonClientTests.swift
//  PokemonDexTests
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import XCTest
import Combine
@testable import PokemonDex

final class PokemonClientTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    override func tearDown() {
        super.tearDown()

        cancellables = []
    }

    func testPokemonClientWhenGivenValidPokemonsData() throws {
        // Given
        let mockedApolloClient = MockApolloClient(url: URL(string: Constants.apolloURL)!)
        let pokemonDummy = Constants.pokemonDummy
        let pokemonTypes: AllPokemonQuery.Data.AllPokemon.`Type` = .init(id: 1, name: "Grass")
        let pokemonData = AllPokemonQuery.Data.AllPokemon(
            id: pokemonDummy.id,
            name: pokemonDummy.name,
            color: pokemonDummy.color,
            generation: pokemonDummy.generation,
            types: [pokemonTypes],
            sprites: AllPokemonQuery.Data.AllPokemon.Sprite(
                frontDefault: pokemonDummy.sprites.frontDefault,
                frontShiny: pokemonDummy.sprites.frontShiny),
            evolvesTo: nil
        )

        mockedApolloClient.data = AllPokemonQuery.Data(allPokemon: [pokemonData])
        let pokemonClient = PokemonClient(apollo: mockedApolloClient)

        // When
        pokemonClient.allPokemon()
        let pokemonCount: Int = pokemonClient.pokemons.count
        XCTAssertEqual(pokemonCount, 1)
    }

    func testPokemonClientWhenGivenInvalidPokemonsData() throws {
        // Given
        let mockedApolloClient = MockApolloClient(url: URL(string: Constants.apolloURL)!)
        let expectedError = NetworkError.failedToDecode
        mockedApolloClient.error = expectedError
        let pokemonClient = PokemonClient(apollo: mockedApolloClient)

        // When
        pokemonClient.allPokemon()

        XCTAssertEqual(pokemonClient.error?.localizedDescription, expectedError.localizedDescription)
    }

    func testPokemonClientWhenGivenValidPokemonSpeciesData() throws {
        // Given
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let url = URL(string: Constants.restURL)
        let pokemontClient = PokemonClient(apolloURL: "", session: urlSession)
        let validData = PokemonSpecies(
            id: 1,
            name: "Bulbasaur",
            order: 1,
            genderRate: 1,
            captureRate: 1,
            baseHappiness: 1,
            isBaby: false,
            isLegendary: false,
            isMythical: false,
            hatchCounter: 1,
            hasGenderDifferences: false,
            formsSwitchable: false,
            growthRate: nil,
            pokedexNumbers: nil,
            eggGroups: nil,
            color: nil,
            shape: nil,
            evolvesFromSpecies: nil,
            evolutionChain: nil,
            habitat: nil,
            generation: Generation(name: "Generation I", url: ""),
            names: nil,
            palParkEncounters: nil,
            flavorTextEntries: nil,
            formDescriptions: nil,
            genera: nil,
            varieties: nil)

        guard let url = url else { throw TestError.unexpectedBehavior }
        let validResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let encodedValidData = try JSONEncoder().encode(validData)

        // When
        MockURLProtocol.stubData = encodedValidData
        MockURLProtocol.stubResponse = validResponse
        let expectation = self.expectation(description: "Pokemon Client Response Expectation")

        pokemontClient
            .getPokemonDescription(pokemonID: 1)
            .sink { res in
                switch res {
                case .finished:
                    break
                case .failure:
                    expectation.fulfill()
                    XCTFail("Unexpected failure in response")
                }
            } receiveValue: { receivedValue in
                expectation.fulfill()
                XCTAssertEqual(receivedValue, validData, "Expected mock response")
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)
    }

    func testPokemonClientWhenGivenInvalidPokemonSpeciesData() throws {
        // Given
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let url = URL(string: Constants.restURL)
        let pokemontClient = PokemonClient(apolloURL: "", session: urlSession)
        let invalidData = "Invalid"
        guard let url = url else { throw TestError.unexpectedBehavior }
        let validResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let encodedInvalidData = try JSONEncoder().encode(invalidData)

        // When
        MockURLProtocol.stubData = encodedInvalidData
        MockURLProtocol.stubResponse = validResponse
        let expectation = self.expectation(description: "Pokemon Client Response Expectation")

        pokemontClient
            .getPokemonDescription(pokemonID: 1)
            .sink { res in
                switch res {
                case .finished:
                    expectation.fulfill()
                    XCTFail("Unexpected success in response")
                case .failure(let error):
                    expectation.fulfill()
                    XCTAssertEqual(error.localizedDescription, NetworkError.failedToDecode.localizedDescription)
                }
            } receiveValue: { _ in
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)
    }

    func testPokemonClientWhenGivenInvalidPokemonSpeciesResponse() throws {
        // Given
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let url = URL(string: Constants.restURL)
        let pokemontClient = PokemonClient(apolloURL: "", session: urlSession)
        let invalidData = "Not Found"
        guard let url = url else { throw TestError.unexpectedBehavior }
        let validResponse = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)
        let encodedInvalidData = try JSONEncoder().encode(invalidData)

        // When
        MockURLProtocol.stubData = encodedInvalidData
        MockURLProtocol.stubResponse = validResponse
        let expectation = self.expectation(description: "Planet Client Response Expectation")

        pokemontClient
            .getPokemonDescription(pokemonID: 1)
            .sink { res in
                switch res {
                case .finished:
                    expectation.fulfill()
                    XCTFail("Unexpected success in response")
                case .failure(let error):
                    expectation.fulfill()
                    XCTAssertEqual(
                        error.localizedDescription,
                        NetworkError.invalidStatusCode(code: 404).localizedDescription
                    )
                }
            } receiveValue: { _ in
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)
    }
}
