//
//  SearchViewModelTest.swift
//  FlickrTests
//
//  Created by Зибейда Алекперли on 03.12.21.
//

import XCTest
@testable import Flickr

class SearchViewModelTest: XCTestCase {
    
    private var sut: SearchViewModel!
    private var apiService: APIServiceProtocol!
    
    override func setUpWithError() throws {
        apiService = TestConstants.testWithMock ? MockAPIService() : APIService()
        sut = SearchViewModel(apiService, search: "Child")
    }

    override func tearDownWithError() throws {
        sut = nil
        apiService = nil
        try super.tearDownWithError()
    }
    
    
    func testInitialLoad() {
        let expectation = self.expectation(description: "Load initial photos")
        initialLoadTest(expectation)
        
        XCTAssertLessThanOrEqual(sut.photosCount, 10)
    }
    
    func testGetNextPhotosFromAPI() {
        let expectationInitial = self.expectation(description: "Load initial photos from API")
        initialLoadTest(expectationInitial)
        let initialCount = sut.photosCount
        
        let expectationNext = self.expectation(description: "Get next photos from API")
        nextLoadTest(expectationNext)
        let currentCount = sut.photosCount
        
        XCTAssertGreaterThanOrEqual(currentCount, initialCount)
    }
    
    func testGetPhotosFromJson() {
        let expectationInitial = self.expectation(description: "Load initial photos from JSON")
        initialLoadTest(expectationInitial)
        let initialCount = sut.photosCount
        
        let expectationNext = self.expectation(description: "Get next photos from JSON")
        nextLoadTest(expectationNext)
        let currentCount = sut.photosCount
        
        XCTAssertGreaterThan(currentCount, initialCount)
        XCTAssertEqual(initialCount, 10)
        XCTAssertEqual(currentCount, 20)
    }

    
    func testGetPhoto() {
        let expectation = self.expectation(description: "Get photo cell view model")
        self.initialLoadTest(expectation)
        let cellViewModel = sut.getPhoto(at: 0)
        if sut.photosCount > 0 {
            XCTAssertNotNil(cellViewModel)
        } else {
            XCTAssertNil(cellViewModel)
        }
    }
    
    private func nextLoadTest(_ expectation: XCTestExpectation) {
        sut.getNextPhotos { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    private func initialLoadTest(_ expectation: XCTestExpectation) {
        sut.initialLoad{ error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
