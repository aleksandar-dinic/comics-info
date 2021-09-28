//
//  ComicDataRepositoryTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Comics_Info__Development_
import XCTest

final class ComicDataRepositoryTests: XCTestCase {

    private var limit: Int!

    override func setUpWithError() throws {
        limit = 20
    }

    override func tearDownWithError() throws {
        limit = nil
    }

    func testGetAllComics() {
        // Given
        let comicDataProvider = ComicDataProviderMockFactory.makeWithComicFromNetwork()
        let sut = ComicDataRepository(comicDataProvider: comicDataProvider)
        let dataSourceLayer = DataSourceLayer.network

        var result: Result<[ComicSummary], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getComicSummaries(for: "", afterID: nil, limit: limit, fromDataSource: dataSourceLayer) {
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
