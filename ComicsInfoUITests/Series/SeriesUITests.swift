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

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testSeriesList() {
        XCTAssertTrue(app.tables.element.waitForExistence(timeout: 5))
    }

    func testTapOnSeries() {
        XCTAssertTrue(app.tables.cells.buttons.firstMatch.isHittable)
    }

}
