//
//  ComicTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct CIData.Comic
@testable import ComicsInfo
import XCTest

class ComicTests: XCTestCase {

    private var cidataComic: CIData.Comic!

    override func setUpWithError() throws {
        cidataComic = CIData.Comic(
            identifier: "1",
            popularity: 0,
            title: "Title",
            thumbnail: "Thumbnail",
            issueNumber: nil,
            description: "Description",
            format: nil,
            pageCount: nil,
            seriesID: ["1"],
            charactersID: ["1"],
            published: nil)
    }

    override func tearDownWithError() throws {
        cidataComic = nil
    }

    func testComicIdentifierMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: cidataComic)

        // Then
        XCTAssertEqual(sut.identifier, cidataComic.identifier)
    }

    func testComicPopularityMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: cidataComic)

        // Then
        XCTAssertEqual(sut.popularity, cidataComic.popularity)
    }

    func testComicTitleMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: cidataComic)

        // Then
        XCTAssertEqual(sut.title, cidataComic.title)
    }

    func testComicThumbnailMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: cidataComic)

        // Then
        XCTAssertEqual(sut.thumbnail, cidataComic.thumbnail)
    }

    func testComicDescriptionMapper() {
        // Given

        // When
        let sut = ComicsInfo.Comic(from: cidataComic)

        // Then
        XCTAssertEqual(sut.description, cidataComic.description)
    }

}
