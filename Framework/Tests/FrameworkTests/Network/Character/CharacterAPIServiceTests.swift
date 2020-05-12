//
//  CharacterAPIServiceTests.swift
//  FrameworkTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Framework
import XCTest

final class CharacterAPIServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Characters

    func testGetCharacters() {
        // Given
        let sut = CharacterAPIProvider()

        var result: Result<Data, Error>?
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

        XCTAssertNoThrow(try res.get())
    }

    // MARK: - Character

    func testGetCharacter() {
        // Given
        let sut = CharacterAPIProvider()
        let characterID = "1"

        var result: Result<Data, Error>?
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

        XCTAssertNoThrow(try res.get())
    }

}
