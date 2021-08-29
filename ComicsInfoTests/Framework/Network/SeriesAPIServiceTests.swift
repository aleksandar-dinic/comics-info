//
//  SeriesAPIServiceTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo__Development_
import XCTest

final class SeriesAPIServiceTests: XCTestCase {

    private var limit: Int!

    override func setUpWithError() throws {
        limit = 20
    }

    override func tearDownWithError() throws {
        limit = nil
    }

    func testGetAllCharacters() {
        // Given
        let sut = SeriesAPIProvider()

        var result: Result<Data, Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllSeries(for: "", afterID: nil, limit: limit) {
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
