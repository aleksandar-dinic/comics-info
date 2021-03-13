//
//  ComicAPIServiceTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo
import XCTest

final class ComicAPIServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetAllComics() {
        // Given
        let sut = ComicAPIProvider()

        var result: Result<Data, Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllComics() {
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
