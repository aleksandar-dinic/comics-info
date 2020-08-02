//
//  ComicAPIWrapperTests.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
@testable import CIData
import XCTest

final class ComicAPIWrapperTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetAllComicSuccess() throws {
        // Given
        let sut = ComicAPIWrapperMockFactory.makeWithComics()
        var result: Result<[Domain.Comic], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllComics(forSeriesID: "1") {
            result = $0
            promise.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5)

        guard let res = result else {
            return XCTFail("Result is nil")
        }

        let comics = try res.get()
        XCTAssertEqual(comics.count, 3)
    }

    func testGetAllComicsFailure() {
        // Given
        let sut = ComicAPIWrapperMockFactory.makeWithoutData()
        var result: Result<[Domain.Comic], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllComics(forSeriesID: "1") {
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

    func testGetAllComicsFailureBadData() {
        // Given
        let sut = ComicAPIWrapperMockFactory.makeWithComicBadData()
        var result: Result<[Domain.Comic], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllComics(forSeriesID: "1") {
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
