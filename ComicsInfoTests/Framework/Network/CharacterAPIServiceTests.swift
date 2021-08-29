//
//  CharacterAPIServiceTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//

@testable import ComicsInfo__Development_
import XCTest

final class CharacterAPIServiceTests: XCTestCase {

    private var sut: CharacterAPIProvider!
    private var limit: Int!

    override func setUpWithError() throws {
        sut = CharacterAPIProvider()
        limit = 20
    }

    override func tearDownWithError() throws {
        sut = nil
        limit = nil
    }

    // MARK: - Characters

    func testGetAllCharacters() {
        // Given
        var result: Result<Data, Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllCharacters(afterID: nil, fields: nil, limit: limit) {
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
