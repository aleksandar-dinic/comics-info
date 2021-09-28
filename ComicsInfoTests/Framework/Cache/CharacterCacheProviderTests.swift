//
//  CharacterCacheProviderTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Comics_Info__Development_
import XCTest

final class CharacterCacheProviderTests: XCTestCase {

    private var givenCharacters: [String: Character]!
    private var cache: Cache<String, Character>!
    private var limit: Int!

    override func setUpWithError() throws {
        givenCharacters = ["1": CharactersMock.character1, "2": CharactersMock.character1]
        cache = Cache<String, Character>()
        limit = 20
        for (_, el) in givenCharacters.enumerated() {
            cache[el.key] = el.value
        }
    }

    override func tearDownWithError() throws {
        cache = nil
        givenCharacters = nil
        limit = nil
    }

    // MARK: - Characters

    func testGetAllCharacters() {
        // Given
        let sut = CharacterCacheProvider(cache)

        // When
        let characters = sut.getAllCharacters(afterID: nil, limit: limit)

        // Then
        XCTAssertEqual(characters?.count, givenCharacters.count)
    }

    func testGetEmptyCharacters() {
        // Given
        let sut = CharacterCacheProvider()

        // When
        let characters = sut.getAllCharacters(afterID: nil, limit: limit)

        // Then
        XCTAssertNil(characters)
    }

    // MARK: - Character

    func testGetCharacterWithID() {
        // Give
        let sut = CharacterCacheProvider(cache)

        // When
        let character = sut.getCharacter(withID: "1")

        // Then
        XCTAssertEqual(character?.identifier, "1")
    }

    func testGetNonExistingCharacterWithID() {
        // Given
        let sut = CharacterCacheProvider()

        // When
        let character = sut.getCharacter(withID: "-1")

        // Then
        XCTAssertNil(character)
    }

    func testSaveCharacters() {
        // Given
        let sut = CharacterCacheProvider(cache)

        // When
        sut.save(characters: Array(givenCharacters.values))

        // Then
        XCTAssertEqual(cache.values()?.count, givenCharacters.count)
    }

}
