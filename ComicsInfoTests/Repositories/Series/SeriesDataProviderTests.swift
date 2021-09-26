//
//  SeriesDataProviderTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo__Development_
import XCTest

final class SeriesDataProviderTests: XCTestCase {

    private var limit: Int!

    override func setUpWithError() throws {
        limit = 20
    }

    override func tearDownWithError() throws {
        limit = nil
    }

    func testGetAllSeriesFromNetwork() throws {
        // Given
        let sut = SeriesDataProviderMockFactory.makeWithSeriesFromNetwork()
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[SeriesSummary], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllSeries(for: "", afterID: nil, limit: limit, fromDataSource: dataSourceLayer) {
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

    func testGetAllSeriesFromMemory() throws {
        // Given
        let sut = SeriesDataProviderMockFactory.makeWithSeriesFromMemory()
        let dataSourceLayer = DataSourceLayer.memory

        var result: Result<[SeriesSummary], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllSeries(for: "", afterID: nil, limit: limit, fromDataSource: dataSourceLayer) {
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

    func testGetAllSeriesFromEmptyMemory() throws {
        // Given
        let sut = SeriesDataProviderMockFactory.makeWithSeriesFromNetwork()
        let dataSourceLayer = DataSourceLayer.memory

        var result: Result<[SeriesSummary], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllSeries(for: "", afterID: nil, limit: limit, fromDataSource: dataSourceLayer) {
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
        let sut = SeriesDataProviderMockFactory.makeWithoutData()
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[SeriesSummary], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllSeries(for: "", afterID: nil, limit: limit, fromDataSource: dataSourceLayer) {
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
