//
//  SeriesDataRepositoryTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo
import XCTest

final class SeriesDataRepositoryTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetAllSeries() {
        // Given
        let seriesDataProvider = SeriesDataProviderMockFactory.makeWithSeriesFromNetwork()
        let sut = SeriesDataRepository(seriesDataProvider: seriesDataProvider)
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[Series], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllSeries(fromDataSource: dataSourceLayer) {
            result = $0
            promise.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5)

        guard let res = result else {
            return XCTFail("Result is nil")
        }

        do {
            let series = try res.get()
            XCTAssertEqual(series.count, 3)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
