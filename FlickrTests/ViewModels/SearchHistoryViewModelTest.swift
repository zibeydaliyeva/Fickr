//
//  SearchHistoryViewModelTest.swift
//  FlickrTests
//
//  Created by Зибейда Алекперли on 03.12.21.
//

import XCTest
@testable import Flickr

class SearchHistoryViewModelTest: XCTestCase {

    private var sut: SearchHistoryViewModel!
    
    override func setUpWithError() throws {
        sut = SearchHistoryViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    
    func testSaveGetHistory() {
        sut.saveHistory(text: "Dog")
        sut.saveHistory(text: "Cat")
        sut.getHistory()
        XCTAssertNotNil(sut.filteredHistoryCount)
        XCTAssertEqual(sut.filteredHistoryCount, 2)
    }
    
    func testGetItem() {
        sut.saveHistory(text: "Dog")
        sut.getHistory()
        let item = sut.getItem(at: 0)
        XCTAssertNotNil(item)
    }
    
    func testGetItemFromEmptyArray() {
        let item = sut.getItem(at: 0)
        XCTAssertNil(item)
    }
    
    func testFilterList() {
        sut.saveHistory(text: "Children")
        sut.saveHistory(text: "Dog")
        sut.saveHistory(text: "chair")
        
        sut.filterList(keyword: "Ch")
        XCTAssertEqual(sut.filteredHistoryCount, 2)
    }
}
