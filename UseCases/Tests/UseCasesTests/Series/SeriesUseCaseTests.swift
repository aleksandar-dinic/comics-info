//
//  SeriesUseCaseTests.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import enum CIData.DataSourceLayer
@testable import UseCases
import XCTest

final class SeriesUseCaseTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetAllSeries() throws {
        // Given
        let seriesRepository = SeriesRepositoryMockFactory.makeWithSeries()
        let sut = SeriesUseCase(seriesRepository: seriesRepository)
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[Domain.Series], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllSeries(forCharacters: ["1"], fromDataSource: dataSourceLayer) {
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

}
