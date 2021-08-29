//
//  SeriesAPIWrapperTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo__Development_
import XCTest

final class SeriesAPIWrapperTests: XCTestCase {

    private var limit: Int!

    override func setUpWithError() throws {
        limit = 20
    }

    override func tearDownWithError() throws {
        limit = nil
    }

    func testGetAllSeriesSuccess() throws {
        // Given
        let sut = SeriesAPIWrapperMockFactory.makeWithSeries()
        var result: Result<[SeriesSummary], Error>?
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

        let series = try res.get()
        XCTAssertEqual(series.count, 3)
    }

    func testGetAllSeriesFailure() {
        // Given
        let sut = SeriesAPIWrapperMockFactory.makeWithoutData()
        var result: Result<[SeriesSummary], Error>?
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

        XCTAssertThrowsError(try res.get())
    }

    func testGetAllSeriesFailureBadData() {
        // Given
        let sut = SeriesAPIWrapperMockFactory.makeWithSeriesBadData()
        var result: Result<[SeriesSummary], Error>?
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

        XCTAssertThrowsError(try res.get())
    }

}
