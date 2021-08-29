//
//  CharacterTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 12/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Character
@testable import ComicsInfo__Development_
import XCTest

final class CharacterTests: XCTestCase {

    private var domainCharacter: Domain.Character!

    override func setUpWithError() throws {
        domainCharacter = Domain.Character(
            identifier: "1",
            popularity: 1,
            name: "Name",
            thumbnail: "Thumbnail",
            description: "Description",
            realName: nil,
            aliases: nil,
            birth: nil,
            series: nil,
            comics: nil
        )
    }

    override func tearDownWithError() throws {
        domainCharacter = nil
    }

    func testCharacterIdentifierMapper() {
        // Given

        // When
        let sut = ComicsInfo__Development_.Character(from: domainCharacter)

        // Then
        XCTAssertEqual(sut.identifier, domainCharacter.identifier)
    }

    func testCharacterPopularityMapper() {
        // Given

        // When
        let sut = ComicsInfo__Development_.Character(from: domainCharacter)

        // Then
        XCTAssertEqual(sut.popularity, domainCharacter.popularity)
    }

    func testCharacterNameMapper() {
        // Given

        // When
        let sut = ComicsInfo__Development_.Character(from: domainCharacter)

        // Then
        XCTAssertEqual(sut.name, domainCharacter.name)
    }

    func testCharacterThumbnailMapper() {
        // Given

        // When
        let sut = ComicsInfo__Development_.Character(from: domainCharacter)

        // Then
        XCTAssertEqual(sut.thumbnail, domainCharacter.thumbnail)
    }

    func testCharacterDescriptionMapper() {
        // Given

        // When
        let sut = ComicsInfo__Development_.Character(from: domainCharacter)

        // Then
        XCTAssertEqual(sut.description, domainCharacter.description)
    }

}
