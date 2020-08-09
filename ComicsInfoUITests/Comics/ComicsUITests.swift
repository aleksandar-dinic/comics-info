//
//  ComicsUITests.swift
//  ComicsInfoUITests
//
//  Created by Aleksandar Dinic on 23/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import XCTest

final class ComicsUITests: XCTestCase {

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

    func testComicsList() {
        // Given
        let seriesList = app.tables.element
        XCTAssertTrue(seriesList.waitForExistence(timeout: 5))
        seriesList.cells.buttons.firstMatch.tap()
        let comicsList = app.tables.element

        // Then
        XCTAssertTrue(comicsList.waitForExistence(timeout: 5))
    }

    func testTapOnComic() {
        // When
        let seriesList = app.tables.element
        XCTAssertTrue(seriesList.waitForExistence(timeout: 5))
        seriesList.cells.buttons.firstMatch.tap()
        let comicsList = app.tables.element
        XCTAssertTrue(comicsList.waitForExistence(timeout: 5))
        comicsList.cells.buttons.firstMatch.tap()

        // Then
        XCTAssertTrue(app.navigationBars.buttons["Amazing Spider-Man"].isHittable)
    }

}
