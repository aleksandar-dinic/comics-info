//
//  SeriesAPIWrapperTests.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
@testable import CIData
import XCTest

final class SeriesAPIWrapperTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetSeriesSuccess() throws {
        // Given
        let sut = SeriesAPIWrapperMockFactory.makeWithSeries()
        var result: Result<[Domain.Series], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getSeries(forCharacterID: "1") {
            result = $0
            promise.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5)

        guard let res = result else {
            return XCTFail("Result is nil")
        }

        let series = try res.get()
        XCTAssertEqual(series.count, 3)
    }

    func testGetSeriesFailure() {
        // Given
        let sut = SeriesAPIWrapperMockFactory.makeWithoutData()
        var result: Result<[Domain.Series], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getSeries(forCharacterID: "1") {
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

    func testGetSeriesFailureBadData() {
        // Given
        let sut = SeriesAPIWrapperMockFactory.makeWithSeriesBadData()
        var result: Result<[Domain.Series], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getSeries(forCharacterID: "1") {
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
