//
//  CharactersUITests.swift
//  ComicsInfoUITests
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import XCTest

class CharactersUITests: XCTestCase {

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

    func testNavigationBarTitle() {
        // Given
        let charactersText = app.staticTexts["Characters"]

        // Then
        XCTAssertTrue(charactersText.exists)
    }

    func testList() {
        // Given
        let characterList = app.tables.element

        // Then
        XCTAssertTrue(characterList.waitForExistence(timeout: 5))
    }

    func testTapOnCharacter() {
        // When
        let characterList = app.tables.element
        XCTAssertTrue(characterList.waitForExistence(timeout: 5))
        characterList.cells.buttons.firstMatch.tap()

        // Then
        XCTAssertTrue(app.navigationBars.buttons["Characters"].isHittable)
    }

}
