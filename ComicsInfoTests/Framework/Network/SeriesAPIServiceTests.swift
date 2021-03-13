//
//  SeriesAPIServiceTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo
import XCTest

final class SeriesAPIServiceTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testGetAllCharacters() {
        // Given
        let sut = SeriesAPIProvider()

        var result: Result<Data, Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllSeries() {
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
