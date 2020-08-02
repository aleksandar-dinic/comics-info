//
//  CharacterUseCaseTests.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import enum CIData.DataSourceLayer
@testable import UseCases
import XCTest

final class CharacterUseCaseTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Characters

    func testGetAllCharacters() {
        // Given
        let characterRepository = CharacterRepositoryMockFactory.makeWithCharacters()
        let sut = CharacterUseCase(characterRepository: characterRepository)
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[Domain.Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllCharacters(fromDataSource: dataSourceLayer) {
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
        let characterRepository = CharacterRepositoryMockFactory.makeWithCharacter()
        let sut = CharacterUseCase(characterRepository: characterRepository)
        let characterID = "1"
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<Domain.Character, Error>?
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
