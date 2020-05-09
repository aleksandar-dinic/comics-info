//
//  CharacterAPIWrapperTests.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
@testable import CIData
import XCTest

final class CharacterAPIWrapperTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Characters

    func testGetCharactersSuccess() {
        // Given
        let sut = CharacterAPIWrapperMockFactory.makeWithCharacters()
        var result: Result<[Domain.Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacters {
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
        let sut = CharacterAPIWrapperMockFactory.makeWithoutData()
        var result: Result<[Domain.Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacters {
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

    func testGetCharactersFailureBadData() {
        // Given
        let sut = CharacterAPIWrapperMockFactory.makeWithCharactersBadData()
        var result: Result<[Domain.Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacters {
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

    func testGetCharacterSuccess() {
        // Given
        let sut = CharacterAPIWrapperMockFactory.makeWithCharacter()
        let characterID = "1"
        var result: Result<Domain.Character, Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacter(withID: characterID) {
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
        let sut = CharacterAPIWrapperMockFactory.makeWithoutData()
        let characterID = "1"
        var result: Result<Domain.Character, Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacter(withID: characterID) {
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

    func testGetCharacterFailureBadData() {
        // Given
        let sut = CharacterAPIWrapperMockFactory.makeWithCharacterBadData()
        let characterID = "1"
        var result: Result<Domain.Character, Error>?
        let promise = expectation(description: #function)

        // When
        sut.getCharacter(withID: characterID) {
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
