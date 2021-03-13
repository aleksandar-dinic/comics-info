//
//  SeriesCacheProviderTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Domain
@testable import ComicsInfo
import XCTest

final class SeriesCacheProviderTests: XCTestCase {

    private var givenSeries: [String: ComicsInfo.Series]!

    override func setUp() {
        super.setUp()
        givenSeries = ["1": SeriesMock.series1, "2": SeriesMock.series2]
    }

    override func tearDown() {
        givenSeries = nil
        super.tearDown()
    }

    func testGetAllSeriesForCharacterID() {
        // Give
        let inMemoryCache = InMemoryCache(storage: givenSeries)
        let sut = SeriesCacheProvider(inMemoryCache)

        // When
        let series = sut.getAllSeries()

        // Then
        XCTAssertEqual(series?.count, givenSeries.count)
    }

//    func testGetAllSeriesWithNonExistingCharacterID() {
//        // Give
//        let inMemoryCache = InMemoryCache(storage: givenSeries)
//        let sut = SeriesCacheProvider(inMemoryCache)
//
//        // When
//        let series = sut.getAllSeries()
//
//        // Then
//        XCTAssertNil(series)
//    }

    func testGetSeriesWithID() {
        // Give
        let inMemoryCache = InMemoryCache(storage: givenSeries)
        let sut = SeriesCacheProvider(inMemoryCache)

        // When
        let series = sut.getSeries(withID: "1")

        // Then
        XCTAssertEqual(series?.identifier, "1")
    }

    func testGetNonExistingSeriesWithID() {
        // Given
        let sut = SeriesCacheProvider()

        // When
        let series = sut.getSeries(withID: "-1")

        // Then
        XCTAssertNil(series)
    }

    func testSaveSeries() {
        // Given
        let inMemoryCache = InMemoryCache<String, ComicsInfo.Series>()
        let sut = SeriesCacheProvider(inMemoryCache)

        // When
        sut.save(series: Array(givenSeries.values))

        // Then
        XCTAssertEqual(inMemoryCache.values.count, givenSeries.count)
    }

}
