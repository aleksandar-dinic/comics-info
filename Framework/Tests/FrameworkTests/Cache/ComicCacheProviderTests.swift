//
//  ComicCacheProviderTests.swift
//  FrameworkTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Domain
@testable import Framework
import XCTest

final class ComicCacheProviderTests: XCTestCase {

    private var givenComics: [String: Domain.Comic]!

    override func setUp() {
        super.setUp()
        let comic1 = Comic(
            identifier: "1",
            popularity: 0,
            title: "Title",
            thumbnail: nil,
            issueNumber: nil,
            description: nil,
            variantDescription: nil,
            format: nil,
            pageCount: nil,
            variantsIdentifier: nil,
            collectionsIdentifier: nil,
            collectedIssuesIdentifier: nil,
            images: nil,
            seriesID: ["1"],
            charactersID: ["1"]
        )
        let comic2 = Comic(
            identifier: "2",
            popularity: 1,
            title: "Title",
            thumbnail: nil,
            issueNumber: nil,
            description: nil,
            variantDescription: nil,
            format: nil,
            pageCount: nil,
            variantsIdentifier: nil,
            collectionsIdentifier: nil,
            collectedIssuesIdentifier: nil,
            images: nil,
            seriesID: ["1"],
            charactersID: ["1"]
        )
        givenComics = ["1": comic1, "2": comic2]
    }

    override func tearDown() {
        givenComics = nil
        super.tearDown()
    }

    func testGetComicsForSeriesID() {
        // Give
        let inMemoryCache = InMemoryCache(storage: givenComics)
        let sut = ComicCacheProvider(inMemoryCache)

        // When
        let comics = sut.getComics(forSeriesID: "1")

        // Then
        XCTAssertEqual(comics?.count, givenComics.count)
    }

    func testGetComicsWithNonExistingSeriesID() {
        // Give
        let inMemoryCache = InMemoryCache(storage: givenComics)
        let sut = ComicCacheProvider(inMemoryCache)

        // When
        let comics = sut.getComics(forSeriesID: "-1")

        // Then
        XCTAssertNil(comics)
    }

    func testGetComicWithID() {
        // Give
        let inMemoryCache = InMemoryCache(storage: givenComics)
        let sut = ComicCacheProvider(inMemoryCache)

        // When
        let comics = sut.getComic(withID: "1")

        // Then
        XCTAssertEqual(comics?.identifier, "1")
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
        let inMemoryCache = InMemoryCache<String, Domain.Comic>()
        let sut = ComicCacheProvider(inMemoryCache)

        // When
        sut.save(comics: Array(givenComics.values))

        // Then
        XCTAssertEqual(inMemoryCache.values.count, givenComics.count)
    }

}
