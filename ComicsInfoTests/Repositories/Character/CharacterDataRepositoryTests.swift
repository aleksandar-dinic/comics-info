//
//  CharacterDataRepositoryTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo__Development_
import XCTest

final class CharacterDataRepositoryTests: XCTestCase {
    
    private var limit: Int!

    override func setUpWithError() throws {
        limit = 20
    }

    override func tearDownWithError() throws {
        limit = nil
    }

    // MARK: - Characters

    func testGetAllCharacters() {
        // Given
        let characterDataProvider = CharacterDataProviderMockFactory.makeWithCharactersFromNetwork()
        let sut = CharacterDataRepository(characterDataProvider: characterDataProvider)
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllCharacters(afterID: nil, fields: nil, limit: limit, fromDataSource: dataSourceLayer) {
            result = $0
            promise.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5)

        guard let res = result else {
            return XCTFail("Result is nil")
        }

        do {
            let characters = try res.get()
            XCTAssertEqual(characters.count, 3)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    // MARK: - Character

    func testGetCharacter() {
        // Given
        let characterDataProvider = CharacterDataProviderMockFactory.makeWithCharacterFromNetwork()
        let sut = CharacterDataRepository(characterDataProvider: characterDataProvider)
        let characterID = "1"
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<Character, Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacter(withID: characterID, fromDataSource: dataSourceLayer) {
            result = $0
            promise.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5)

        guard let res = result else {
            return XCTFail("Result is nil")
        }

        do {
            let character = try res.get()
            XCTAssertEqual(character.identifier, characterID)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
