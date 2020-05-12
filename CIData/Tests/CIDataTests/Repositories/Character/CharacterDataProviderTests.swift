//
//  CharacterDataProviderTests.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
@testable import CIData
import XCTest

final class CharacterDataProviderTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Characters

    func testGetCharactersFromNetwork() {
        // Given
        let sut = CharacterDataProviderMockFactory.makeWithCharactersFromNetwork()
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[Domain.Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacters(fromDataSource: dataSourceLayer) {
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

    func testGetCharactersFromMemory() {
        // Given
        let sut = CharacterDataProviderMockFactory.makeWithCharactersFromMemory()
        let dataSourceLayer = DataSourceLayer.memory

        var result: Result<[Domain.Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacters(fromDataSource: dataSourceLayer) {
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

    func testGetCharactersFromEmptyMemory() {
        // Given
        let sut = CharacterDataProviderMockFactory.makeWithCharactersFromNetwork()
        let dataSourceLayer = DataSourceLayer.memory

        var result: Result<[Domain.Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacters(fromDataSource: dataSourceLayer) {
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

    func testGetCharactersFailure() {
        // Given
        let sut = CharacterDataProviderMockFactory.makeWithoutData()
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[Domain.Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacters(fromDataSource: dataSourceLayer) {
            result = $0
            promise.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5)

        guard let res = result else {
            return XCTFail("Result is nil")
        }

        XCTAssertThrowsError(try res.get())
    }

    // MARK: - Character

    func testGetCharacterFromNetwork() {
        // Given
        let sut = CharacterDataProviderMockFactory.makeWithCharacterFromNetwork()
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

    func testGetCharacterFromMemory() {
        // Given
        let sut = CharacterDataProviderMockFactory.makeWithCharacterFromMemory()
        let characterID = "1"
        let dataSourceLayer = DataSourceLayer.memory

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

    func testGetCharacterFromEmptyMemory() {
        // Given
        let sut = CharacterDataProviderMockFactory.makeWithCharacterFromNetwork()
        let characterID = "1"
        let dataSourceLayer = DataSourceLayer.memory

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

    func testGetCharacterFailure() {
        // Given
        let sut = CharacterDataProviderMockFactory.makeWithoutData()
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

        XCTAssertThrowsError(try res.get())
    }

}
