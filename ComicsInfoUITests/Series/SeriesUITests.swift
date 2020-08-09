//
//  SeriesUITests.swift
//  ComicsInfoUITests
//
//  Created by Aleksandar Dinic on 21/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import XCTest

final class SeriesUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testSeriesList() {
        // Given
        let seriesList = app.tables.element
        XCTAssertTrue(seriesList.waitForExistence(timeout: 5))

        // Then
        XCTAssertTrue(seriesList.waitForExistence(timeout: 5))
    }

    func testTapOnSeries() {
        // When
        let seriesList = app.tables.element
        XCTAssertTrue(seriesList.waitForExistence(timeout: 5))
        seriesList.cells.buttons.firstMatch.tap()

        // Then
        XCTAssertTrue(app.navigationBars.buttons["Discover"].isHittable)
    }

}
