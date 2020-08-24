//
//  CharacterCacheProviderTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
@testable import ComicsInfo
import XCTest

final class CharacterCacheProviderTests: XCTestCase {

    private var givenCharacters: [String: ComicsInfo.Character]!
    private var inMemoryCache: InMemoryCache<String, ComicsInfo.Character>!

    override func setUpWithError() throws {
        givenCharacters = ["1": CharactersMock.character1, "2": CharactersMock.character1]
        inMemoryCache = InMemoryCache(storage: givenCharacters)
    }

    override func tearDownWithError() throws {
        inMemoryCache = nil
        givenCharacters = nil
    }

    // MARK: - Characters

    func testGetAllCharacters() {
        // Given
        let sut = CharacterCacheProvider(inMemoryCache)

        // When
        let characters = sut.getAllCharacters()

        // Then
        XCTAssertEqual(characters?.count, givenCharacters.count)
    }

    func testGetEmptyCharacters() {
        // Given
        let sut = CharacterCacheProvider()

        // When
        let characters = sut.getAllCharacters()

        // Then
        XCTAssertNil(characters)
    }

    // MARK: - Character

    func testGetCharacterWithID() {
        // Give
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
        let sut = CharacterCacheProvider(inMemoryCache)

        // When
        sut.save(characters: Array(givenCharacters.values.map({ CIData.Character(from: $0) })))

        // Then
        XCTAssertEqual(inMemoryCache.values.count, givenCharacters.count)
    }

}
