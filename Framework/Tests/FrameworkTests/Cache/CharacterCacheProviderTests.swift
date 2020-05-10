//
//  CharacterCacheProviderTests.swift
//  FrameworkTests
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Domain
@testable import Framework
import XCTest

final class CharacterCacheProviderTests: XCTestCase {

    private var givenCharacters: [String: Domain.Character]!

    override func setUp() {
        super.setUp()
        let character1 = Character(
            identifier: "1",
            popularity: 0,
            name: "Name",
            thumbnail: nil,
            description: nil
        )
        let character2 = Character(
            identifier: "2",
            popularity: 0,
            name: "Name",
            thumbnail: nil,
            description: nil
        )
        givenCharacters = ["1": character1, "2": character2]
    }

    override func tearDown() {
        givenCharacters = nil
        super.tearDown()
    }

    // MARK: - Characters

    func testGetCharacters() {
        // Given
        let inMemoryCache = InMemoryCache(storage: givenCharacters)
        let sut = CharacterCacheProvider(inMemoryCache)

        // When
        let characters = sut.getCharacters()

        // Then
        XCTAssertEqual(characters?.count, givenCharacters.count)
    }

    func testGetEmptyCharacters() {
        // Given
        let sut = CharacterCacheProvider()

        // When
        let characters = sut.getCharacters()

        // Then
        XCTAssertNil(characters)
    }

    // MARK: - Character

    func testGetCharacterWithID() {
        // Give
        let inMemoryCache = InMemoryCache(storage: givenCharacters)
        let sut = CharacterCacheProvider(inMemoryCache)

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
        let inMemoryCache = InMemoryCache<String, Domain.Character>()
        let sut = CharacterCacheProvider(inMemoryCache)

        // When
        sut.save(characters: Array(givenCharacters.values))

        // Then
        XCTAssertEqual(inMemoryCache.values.count, givenCharacters.count)
    }

}
