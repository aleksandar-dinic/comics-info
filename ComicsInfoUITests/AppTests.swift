//
//  AppTests.swift
//  ComicsInfoUITests
//
//  Created by Aleksandar Dinic on 12/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import XCTest

class AppTests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testLaunchPerformance() {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            app.launch()
        }
    }

    func testReturnFromBackground() {
        app.launch()
        XCTAssertTrue(app.tables.element.waitForExistence(timeout: 5))

        XCUIDevice.shared.press(.home)

        XCTAssertTrue(app.wait(for: .runningBackground, timeout: 5))

        app.activate()
        XCTAssertEqual(app.state, .runningForeground)
        XCTAssertTrue(app.tables.element.exists)
    }

}
