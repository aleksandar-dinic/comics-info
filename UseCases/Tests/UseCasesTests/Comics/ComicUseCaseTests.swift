//
//  ComicUseCaseTests.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Comic
import enum CIData.DataSourceLayer
@testable import UseCases
import XCTest

final class ComicUseCaseTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetAllComics() throws {
        // Given
        let comicRepository = ComicRepositoryMockFactory.makeWithComics()
        let sut = ComicUseCase(comicRepository: comicRepository)
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[CIData.Comic], Error>?
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

        let comics = try res.get()
        XCTAssertEqual(comics.count, 3)
    }

}
