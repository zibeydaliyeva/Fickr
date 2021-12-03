//
//  RouterTest.swift
//  FlickrTests
//
//  Created by Зибейда Алекперли on 03.12.21.
//

import XCTest
@testable import Flickr

class RouterTest: XCTestCase {

    func testGetPhotos() {
        let router = Router.getPhotos(text: "cat", page: 1)
        
        do {
            let request = try router.request()
            XCTAssertNotNil(request.allHTTPHeaderFields)
            let value = request.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            XCTAssertEqual(value, ContentType.json.rawValue)
        } catch {
            XCTFail()
        }
    }
    
    func testIfWrongURLThrowAnError() {
        let wrongRatesString = "?t=cat"
        let router = Router.getPhotos(text: wrongRatesString, page: 1)
        do {
            _ = try router.request()
        } catch {
            XCTAssertThrowsError(error)
        }
    }
}
