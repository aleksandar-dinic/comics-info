//
//  SeriesDataProviderTests.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
@testable import CIData
import XCTest

final class SeriesDataProviderTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetSeriesFromNetwork() throws {
        // Given
        let sut = SeriesDataProviderMockFactory.makeWithSeriesFromNetwork()
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[Domain.Series], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getSeries(forCharacterID: "1", fromDataSource: dataSourceLayer) {
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

    func testGetSeriesFromMemory() throws {
        // Given
        let sut = SeriesDataProviderMockFactory.makeWithSeriesFromMemory()
        let dataSourceLayer = DataSourceLayer.memory

        var result: Result<[Domain.Series], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getSeries(forCharacterID: "1", fromDataSource: dataSourceLayer) {
            result = $0
            promise.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5)

        guard let res = result else {
            return XCTFail("Result is nil")
        }

        let series = try res.get()
        XCTAssertEqual(series.count, 1)
    }

    func testGetSeriesFromEmptyMemory() throws {
        // Given
        let sut = SeriesDataProviderMockFactory.makeWithSeriesFromNetwork()
        let dataSourceLayer = DataSourceLayer.memory

        var result: Result<[Domain.Series], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getSeries(forCharacterID: "1", fromDataSource: dataSourceLayer) {
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
        let sut = SeriesDataProviderMockFactory.makeWithoutData()
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[Domain.Series], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getSeries(forCharacterID: "1", fromDataSource: dataSourceLayer) {
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
