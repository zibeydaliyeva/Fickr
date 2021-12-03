//
//  FlickrUITests.swift
//  FlickrUITests
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import XCTest

class FlickrUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testHistorySearchFilter() throws {
        let searchField = app.searchFields["Search"]
        let historyTable = app.tables.firstMatch
        let cellsCount = historyTable.cells.count
        
        searchField.tap()
        searchField.typeText("cat")
        let currentCellsCount = historyTable.cells.count
        XCTAssertLessThanOrEqual(currentCellsCount, cellsCount)
    }

    func testCancelSearch() throws {
        let searchField = app.searchFields["Search"]
        let historyTable = app.tables.firstMatch
        let cellsCount = historyTable.cells.count
        
        searchField.tap()
        searchField.typeText("Sky")
        searchField.buttons.firstMatch.tap()
        let currentCellsCount = historyTable.cells.count
        XCTAssertEqual(currentCellsCount, cellsCount)
        
        
    }
    
    func testSearchResult() throws {
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("cat")
        XCUIApplication().keyboards.buttons["Search"].tap()
        let collection = app.collectionViews.firstMatch
        let predicate = NSPredicate(format: "exists == true")
        
        expectation(for: predicate, evaluatedWith: collection, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertLessThanOrEqual(collection.cells.count, 10)
    }
}
