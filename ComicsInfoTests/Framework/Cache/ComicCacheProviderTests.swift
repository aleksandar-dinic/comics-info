//
//  ComicCacheProviderTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Comic
@testable import ComicsInfo
import XCTest

final class ComicCacheProviderTests: XCTestCase {

    private var givenComics: [String: ComicsInfo.Comic]!

    override func setUpWithError() throws {
        let comic1 = ComicsInfo.Comic.make(identifier: "1", popularity: 0, title: "Title")
        let comic2 = ComicsInfo.Comic.make(identifier: "2", popularity: 1, title: "Title")
        givenComics = ["1": comic1, "2": comic2]
    }

    override func tearDownWithError() throws {
        givenComics = nil
    }

    func testGetAllComicsForSeriesID() {
        // Give
        let inMemoryCache = InMemoryCache(storage: givenComics)
        let sut = ComicCacheProvider(inMemoryCache)

        // When
        let comics = sut.getAllComics()

        // Then
        XCTAssertEqual(comics?.count, givenComics.count)
    }

//    func testGetAllComicsWithNonExistingSeriesID() {
//        // Give
//        let inMemoryCache = InMemoryCache(storage: givenComics)
//        let sut = ComicCacheProvider(inMemoryCache)
//
//        // When
//        let comics = sut.getAllComics()
//
//        // Then
//        XCTAssertNil(comics)
//    }

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
        let inMemoryCache = InMemoryCache<String, ComicsInfo.Comic>()
        let sut = ComicCacheProvider(inMemoryCache)

        // When
        sut.save(comics: Array(givenComics.values))

        // Then
        XCTAssertEqual(inMemoryCache.values.count, givenComics.count)
    }

}
