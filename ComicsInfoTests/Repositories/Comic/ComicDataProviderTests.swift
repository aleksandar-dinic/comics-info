//
//  ComicDataProviderTests.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo__Development_
import XCTest

final class ComicDataProviderTests: XCTestCase {

    private var limit: Int!

    override func setUpWithError() throws {
        limit = 20
    }

    override func tearDownWithError() throws {
        limit = nil
    }

    func testGetAllComicsFromNetwork() throws {
        // Given
        let sut = ComicDataProviderMockFactory.makeWithComicFromNetwork()
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

        let comics = try res.get()
        XCTAssertEqual(comics.count, 3)
    }

    func testGetAllComicsFromMemory() throws {
        // Given
        let sut = ComicDataProviderMockFactory.makeWithComicFromMemory()
        let dataSourceLayer = DataSourceLayer.memory

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

        let comics = try res.get()
        XCTAssertEqual(comics.count, 3)
    }

    func testGetAllComicsFromEmptyMemory() throws {
        // Given
        let sut = ComicDataProviderMockFactory.makeWithComicFromNetwork()
        let dataSourceLayer = DataSourceLayer.memory

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

        let comics = try res.get()
        XCTAssertEqual(comics.count, 3)
    }

    func testGetAllComicsFailure() {
        // Given
        let sut = ComicDataProviderMockFactory.makeWithoutData()
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

        XCTAssertThrowsError(try res.get())
    }

}
