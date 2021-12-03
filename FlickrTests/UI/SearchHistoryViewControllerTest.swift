//
//  SearchHistoryViewControllerTest.swift
//  FlickrTests
//
//  Created by Зибейда Алекперли on 03.12.21.
//

import XCTest
@testable import Flickr

class SearchHistoryViewControllerTest: XCTestCase {
    
    private var sut: SearchHistoryViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchHistoryViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

}
