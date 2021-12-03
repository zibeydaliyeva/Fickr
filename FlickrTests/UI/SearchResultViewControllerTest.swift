//
//  SearchResultViewControllerTest.swift
//  FlickrTests
//
//  Created by Зибейда Алекперли on 03.12.21.
//

import XCTest
@testable import Flickr

class SearchResultViewControllerTest: XCTestCase {
    
    private var sut: SearchResultViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchResultViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

}
