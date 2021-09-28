//
//  SeriesCacheProviderTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Comics_Info__Development_
import XCTest

final class SeriesCacheProviderTests: XCTestCase {
    
    private var cache: Cache<String, Series>!
    private var cacheSummaries: Cache<String, [SeriesSummary]>!
    
    private var characterID: String!
    private var limit: Int!
    
    override func setUpWithError() throws {
        cache = Cache<String, Series>()
        let series1 = Series.make(identifier: "Series1")
        let series2 = Series.make(identifier: "Series2")
        cache[series1.identifier] = series1
        cache[series2.identifier] = series2
        characterID = "CharacterID"
        
        let seriesSummary1 = SeriesSummary.make(identifier: "SeriesSummary1")
        let seriesSummary2 = SeriesSummary.make(identifier: "SeriesSummary2")
        
        cacheSummaries = Cache<String, [SeriesSummary]>()
        cacheSummaries[characterID] = [seriesSummary1, seriesSummary2]
        limit = 20
    }

    override func tearDownWithError() throws {
        cache = nil
        cacheSummaries = nil
        characterID = nil
        limit = nil
    }

    func testGetAllSeriesForCharacterID() {
        // Give
        let sut = SeriesCacheProvider(seriesSumariesCache: cacheSummaries)

        // When
        let series = sut.getAllSeries(for: characterID, afterID: nil, limit: limit)

        // Then
        XCTAssertEqual(series?.count, 2)
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
        let sut = SeriesCacheProvider(seriesCache: cache)

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
        let sut = SeriesCacheProvider()

        // When
        sut.save(series: SeriesMock.series1)
        sut.save(series: SeriesMock.series2)

        // Then
        XCTAssertEqual(cache.values()?.count, 2)
    }

}
