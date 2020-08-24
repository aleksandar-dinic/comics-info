//
//  CharacterUseCaseTests.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Character
import enum CIData.DataSourceLayer
@testable import UseCases
import XCTest

final class CharacterUseCaseTests: XCTestCase {

    private var dataSourceLayer: DataSourceLayer!

    override func setUp() {
        super.setUp()
        dataSourceLayer = .network
    }

    override func tearDown() {
        dataSourceLayer = nil
        super.tearDown()
    }

    // MARK: - Characters

    func testGetAllCharacters() {
        // Given
        let characterRepository = CharacterRepositoryMockFactory.makeWithCharacters()
        let sut = CharacterUseCase(characterRepository: characterRepository)

        var result: Result<[CIData.Character], Error>?
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

        var result: Result<CIData.Character, Error>?
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
