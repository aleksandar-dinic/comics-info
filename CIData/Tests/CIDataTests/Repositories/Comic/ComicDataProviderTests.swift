//
//  ComicDataProviderTests.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
@testable import CIData
import XCTest

final class ComicDataProviderTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetAllComicsFromNetwork() throws {
        // Given
        let sut = ComicDataProviderMockFactory.makeWithComicFromNetwork()
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

        let comics = try res.get()
        XCTAssertEqual(comics.count, 3)
    }

    func testGetAllComicsFromMemory() throws {
        // Given
        let sut = ComicDataProviderMockFactory.makeWithComicFromMemory()
        let dataSourceLayer = DataSourceLayer.memory

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

        let comics = try res.get()
        XCTAssertEqual(comics.count, 1)
    }

    func testGetAllComicsFromEmptyMemory() throws {
        // Given
        let sut = ComicDataProviderMockFactory.makeWithComicFromNetwork()
        let dataSourceLayer = DataSourceLayer.memory

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

        let comics = try res.get()
        XCTAssertEqual(comics.count, 3)
    }

    func testGetAllComicsFailure() {
        // Given
        let sut = ComicDataProviderMockFactory.makeWithoutData()
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

        XCTAssertThrowsError(try res.get())
    }

}
