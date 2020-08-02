//
//  ComicDataRepositoryTests.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
@testable import CIData
import XCTest

final class ComicDataRepositoryTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetAllComics() {
        // Given
        let comicDataProvider = ComicDataProviderMockFactory.makeWithComicFromNetwork()
        let sut = ComicDataRepository(comicDataProvider: comicDataProvider)
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[Domain.Comic], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllComics(forSeriesID: "1", fromDataSource: dataSourceLayer) {
            result = $0
            promise.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5)

        guard let res = result else {
            return XCTFail("Result is nil")
        }

        do {
            let comics = try res.get()
            XCTAssertEqual(comics.count, 3)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
