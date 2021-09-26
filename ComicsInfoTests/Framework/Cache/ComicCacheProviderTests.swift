//
//  ComicCacheProviderTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo__Development_
import XCTest

final class ComicCacheProviderTests: XCTestCase {
    
    private var cache: Cache<String, Comic>!
    private var cacheSummaries: Cache<String, [ComicSummary]>!

    private var seriesID: String!
    private var limit: Int!

    override func setUpWithError() throws {
        cache = Cache<String, Comic>()
        let comic1 = Comic.make(identifier: "Comic1")
        cache[comic1.identifier] = comic1
        let comic2 = Comic.make(identifier: "Comic2")
        cache[comic2.identifier] = comic2
        
        cacheSummaries = Cache<String, [ComicSummary]>()
        seriesID = "SeriesID"
        let comicSummary1 = ComicSummary.make(identifier: "ComicSummary1")
        let comicSummary2 = ComicSummary.make(identifier: "ComicSummary2")
        cacheSummaries[seriesID] = [comicSummary1, comicSummary2]
        
        limit = 20
    }

    override func tearDownWithError() throws {
        cache = nil
        cacheSummaries = nil
        seriesID = nil
        limit = nil
    }

    func testGetAllComicsForSeriesID() {
        // Given
        let sut = ComicCacheProvider(comicSummaryCache: cacheSummaries)

        // When
        let comics = sut.getComicSummaries(for: seriesID, afterID: nil, limit: 20)

        // Then
        XCTAssertEqual(comics?.count, cache.values()?.count)
    }

    func testGetComicWithID() {
        // Given
        let sut = ComicCacheProvider(comicCache: cache)

        // When
        let comics = sut.getComic(withID: "Comic1")

        // Then
        XCTAssertEqual(comics?.identifier, "Comic1")
    }

    func testGetNonExistingComicWithID() {
        // Given
        let sut = ComicCacheProvider()

        // When
        let comics = sut.getComic(withID: "-1")

        // Then
        XCTAssertNil(comics)
    }

    func testSaveComics() {
        // Given
        let sut = ComicCacheProvider()

        // When
        sut.save(comic: Comic.make(identifier: "ComicID1"))
        sut.save(comic: Comic.make(identifier: "ComicID2"))

        // Then
        XCTAssertEqual(cache.values()?.count, 2)
    }

}
