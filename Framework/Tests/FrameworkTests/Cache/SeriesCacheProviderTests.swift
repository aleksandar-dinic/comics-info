//
//  SeriesCacheProviderTests.swift
//  FrameworkTests
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Domain
@testable import Framework
import XCTest

final class SeriesCacheProviderTests: XCTestCase {

    private var givenSeries: [String: Domain.Series]!

    override func setUp() {
        super.setUp()
        let series1 = Series(
            identifier: "1",
            popularity: 0,
            title: "Title",
            description: nil,
            startYear: nil,
            endYear: nil,
            thumbnail: nil,
            charactersID: ["1"],
            nextIdentifier: nil
        )
        let series2 = Series(
            identifier: "2",
            popularity: 0,
            title: "Title",
            description: nil,
            startYear: nil,
            endYear: nil,
            thumbnail: nil,
            charactersID: ["1"],
            nextIdentifier: nil
        )
        givenSeries = ["1": series1, "2": series2]
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
        let series = sut.getAllSeries(forCharacters: ["1"])

        // Then
        XCTAssertEqual(series?.count, givenSeries.count)
    }

    func testGetAllSeriesWithNonExistingCharacterID() {
        // Give
        let inMemoryCache = InMemoryCache(storage: givenSeries)
        let sut = SeriesCacheProvider(inMemoryCache)

        // When
        let series = sut.getAllSeries(forCharacters: ["-1"])

        // Then
        XCTAssertNil(series)
    }

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
        let inMemoryCache = InMemoryCache<String, Domain.Series>()
        let sut = SeriesCacheProvider(inMemoryCache)

        // When
        sut.save(series: Array(givenSeries.values))

        // Then
        XCTAssertEqual(inMemoryCache.values.count, givenSeries.count)
    }

}
