//
//  CharactersWithSeriesUseCaseTests.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Character
import enum CIData.DataSourceLayer
@testable import UseCases
import XCTest

final class CharactersWithSeriesUseCaseTests: XCTestCase {

    private var dataSourceLayer: DataSourceLayer!

    override func setUp() {
        super.setUp()
        dataSourceLayer = .network
    }

    override func tearDown() {
        dataSourceLayer = nil
        super.tearDown()
    }

    // MARK: - Characters

    func testGetAllCharactersWithSeries() {
        // Given
        let characterRepository = CharacterRepositoryMockFactory.makeWithCharacters()
        let characterUseCase = CharacterUseCase(characterRepository: characterRepository)

        let seriesRepository = SeriesRepositoryMockFactory.makeWithSeries()
        let seriesUseCase = SeriesUseCase(seriesRepository: seriesRepository)

        let sut = CharactersWithSeriesUseCase(
            characterUseCase: characterUseCase,
            seriesUseCase: seriesUseCase
        )

        var result: Result<[CIData.Character], Error>?
        let promise = expectation(description: #function)

        // When
        sut.getAllCharactersWithSeries(fromDataSource: dataSourceLayer) {
            result = $0
            promise.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5)

        guard let res = result else {
            return XCTFail("Result is nil")
        }

        do {
            let characters = try res.get()
            XCTAssertEqual(characters.count, 3)
            XCTAssertEqual(characters.first?.series.count, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
