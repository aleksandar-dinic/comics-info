//
//  SeriesTests.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Series
@testable import CIData
import XCTest

final class SeriesTests: XCTestCase {

    private var domainSeries: Domain.Series!

    override func setUpWithError() throws {
        domainSeries = Domain.Series(
            identifier: "1",
            popularity: 0,
            title: "Title",
            description: "description",
            startYear: 1,
            endYear: 2,
            thumbnail: "thumbnail",
            charactersID: ["1"],
            nextIdentifier: "nextIdentifier"
        )
    }

    override func tearDownWithError() throws {
        domainSeries = nil
    }

    func testSeriesIdentifierMapper() {
        // Given

        // When
        let sut = CIData.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.identifier, domainSeries.identifier)
    }

    func testSeriesPopularityMapper() {
        // Given

        // When
        let sut = CIData.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.popularity, domainSeries.popularity)
    }

    func testSeriesTitleMapper() {
        // Given

        // When
        let sut = CIData.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.title, domainSeries.title)
    }

    func testSeriesThumbnailMapper() {
        // Given

        // When
        let sut = CIData.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.thumbnail, domainSeries.thumbnail)
    }

    func testSeriesDescriptionMapper() {
        // Given

        // When
        let sut = CIData.Series(from: domainSeries)

        // Then
        XCTAssertEqual(sut.description, domainSeries.description)
    }

}
