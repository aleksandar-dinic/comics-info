//
//  ComicInfoUITests.swift
//  ComicsInfoUITests
//
//  Created by Aleksandar Dinic on 09/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import XCTest

final class ComicInfoUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testComicInfoThumbnailExists() {
        // Given
        let seriesList = app.tables.element
        seriesList.cells.buttons.firstMatch.tap()
        let comicsList = app.tables.element
        comicsList.cells.buttons.firstMatch.tap()

        // Then
        XCTAssertTrue(app.scrollViews.otherElements.images["ComicThumbnailView"].exists)
    }

}
