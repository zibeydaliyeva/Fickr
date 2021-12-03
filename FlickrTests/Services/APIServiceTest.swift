//
//  APIServiceTest.swift
//  FlickrTests
//
//  Created by Зибейда Алекперли on 03.12.21.
//

import XCTest
@testable import Flickr

class APIServiceTest: XCTestCase {
    
    private var sut: APIServiceProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TestConstants.testWithMock ? MockAPIService() : APIService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }


    func testGetPhotosFromAPIServer() {
        let expectation = self.expectation(description: "fetch photos from api")
        sut.getPhotos(text: "Cat", page: 1) { result in
            switch result {
            case .success(let data):
                if let photos = data?.photos.photo {
                    XCTAssertNotNil(data)
                    XCTAssertLessThanOrEqual(photos.count, 10)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

}

class MockAPIService: APIServiceProtocol {
    func getPhotos(text: String, page: Int, completion: @escaping ResponseResult<Search?>) {
        guard let data = dataFromTestBundleFile(fileName: "SearchPhotos", withExtension: "json") else {
            completion(.failure(.fileNotFound("search photos")))
            return XCTFail("file is not exist")
        }
        do {
            let mockData = try JSONDecoder().decode(Search.self, from: data)
            completion(.success(mockData))
        } catch {
            completion(.failure(ErrorService.parseError))
        }
    }
    
    
    private func dataFromTestBundleFile(fileName: String, withExtension fileExtension: String) -> Data? {

        let testBundle = Bundle(for: APIServiceTest.self)
        let resourceUrl = testBundle.url(forResource: fileName, withExtension: fileExtension)!
        do {
            let data = try Data(contentsOf: resourceUrl)
            return data
        } catch {
            XCTFail("Error reading data from resource file \(fileName).\(fileExtension)")
            return nil
        }
    }
}
