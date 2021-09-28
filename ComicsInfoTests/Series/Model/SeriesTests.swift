//
//  SeriesTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Series
@testable import Comics_Info__Development_
import XCTest

class SeriesTests: XCTestCase {

    private var domainSeries: Domain.Series!

    override func setUpWithError() throws {
        domainSeries = Domain.Series(
            identifier: "1",
            popularity: 0,
            title: "Title",
            thumbnail: "Thumbnail",
            description: "Description",
            startYear: nil,
            endYear: nil,
            aliases: nil,
            nextIdentifier: nil,
            characters: nil,
            comics: nil
        )
    }

    override func tearDownWithError() throws {
        domainSeries = nil
    }

    func testSeriesIdentifierMapper() {
        // Given

        // When
        let sut = Comics_Info__Development_.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.identifier, domainSeries.identifier)
    }

    func testSeriesPopularityMapper() {
        // Given

        // When
        let sut = Comics_Info__Development_.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.popularity, domainSeries.popularity)
    }

    func testSeriesTitleMapper() {
        // Given

        // When
        let sut = Comics_Info__Development_.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.title, domainSeries.title)
    }

    func testSeriesThumbnailMapper() {
        // Given

        // When
        let sut = Comics_Info__Development_.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.thumbnail, domainSeries.thumbnail)
    }

    func testSeriesDescriptionMapper() {
        // Given

        // When
        let sut = Comics_Info__Development_.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.description, domainSeries.description)
    }

}
