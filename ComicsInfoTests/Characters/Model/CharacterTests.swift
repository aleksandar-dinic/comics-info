//
//  CharacterTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 12/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct CIData.Character
@testable import ComicsInfo
import XCTest

class CharacterTests: XCTestCase {

    private var cidataCharacter: CIData.Character!

    override func setUpWithError() throws {
        cidataCharacter = CIData.Character(
            identifier: "1",
            popularity: 1,
            name: "Name",
            thumbnail: "Thumbnail",
            description: "Description",
            series: []
        )
    }

    override func tearDownWithError() throws {
        cidataCharacter = nil
    }

    func testCharacterIdentifierMapper() {
        // Given

        // When
        let sut = ComicsInfo.Character(from: cidataCharacter)

        // Then
        XCTAssertEqual(sut.identifier, cidataCharacter.identifier)
    }

    func testCharacterPopularityMapper() {
        // Given

        // When
        let sut = ComicsInfo.Character(from: cidataCharacter)

        // Then
        XCTAssertEqual(sut.popularity, cidataCharacter.popularity)
    }

    func testCharacterNameMapper() {
        // Given

        // When
        let sut = ComicsInfo.Character(from: cidataCharacter)

        // Then
        XCTAssertEqual(sut.name, cidataCharacter.name)
    }

    func testCharacterThumbnailMapper() {
        // Given

        // When
        let sut = ComicsInfo.Character(from: cidataCharacter)

        // Then
        XCTAssertEqual(sut.thumbnail, cidataCharacter.thumbnail)
    }

    func testCharacterDescriptionMapper() {
        // Given

        // When
        let sut = ComicsInfo.Character(from: cidataCharacter)

        // Then
        XCTAssertEqual(sut.description, cidataCharacter.description)
    }

}
