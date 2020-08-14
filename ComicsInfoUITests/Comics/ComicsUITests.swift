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

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testComicsList() {
        let seriesList = app.tables.element
        seriesList.cells.buttons.firstMatch.tap()

        XCTAssertTrue(app.tables.element.waitForExistence(timeout: 5))
    }

    func testTapOnComic() {
        let seriesList = app.tables.element
        seriesList.cells.buttons.firstMatch.tap()

        XCTAssertTrue(app.tables.cells.buttons.firstMatch.isHittable)
    }

}
