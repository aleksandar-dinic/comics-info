//
//  SeriesDataRepositoryTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Comics_Info__Development_
import XCTest

final class SeriesDataRepositoryTests: XCTestCase {

    private var limit: Int!

    override func setUpWithError() throws {
        limit = 20
    }

    override func tearDownWithError() throws {
        limit = nil
    }

    func testGetAllSeries() {
        // Given
        let seriesDataProvider = SeriesDataProviderMockFactory.makeWithSeriesFromNetwork()
        let sut = SeriesDataRepository(seriesDataProvider: seriesDataProvider)
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

        do {
            let series = try res.get()
            XCTAssertEqual(series.count, 3)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
