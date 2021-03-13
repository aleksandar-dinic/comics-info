//
//  ComicTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Comic
@testable import ComicsInfo
import XCTest

class ComicTests: XCTestCase {

    private var domainComic: Domain.Comic!

    override func setUpWithError() throws {
        domainComic = Domain.Comic(
            identifier: "1",
            popularity: 0,
            title: "Title",
            thumbnail: "Thumbnail",
            description: "Description",
            number: nil,
            aliases: nil,
            variantDescription: nil,
            format: nil,
            pageCount: nil,
            variantsIdentifier: nil,
            collectionsIdentifier: nil,
            collectedIdentifiers: nil,
            images: nil,
            published: nil,
            characters: nil,
            series: nil
        )
    }

    override func tearDownWithError() throws {
        domainComic = nil
    }

    func testComicIdentifierMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: domainComic)

        // Then
        XCTAssertEqual(sut.identifier, domainComic.identifier)
    }

    func testComicPopularityMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: domainComic)

        // Then
        XCTAssertEqual(sut.popularity, domainComic.popularity)
    }

    func testComicTitleMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: domainComic)

        // Then
        XCTAssertEqual(sut.title, domainComic.title)
    }

    func testComicThumbnailMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: domainComic)

        // Then
        XCTAssertEqual(sut.thumbnail, domainComic.thumbnail)
    }

    func testComicDescriptionMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: domainComic)

        // Then
        XCTAssertEqual(sut.description, domainComic.description)
    }

}
