//
//  Router.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import Foundation

enum Router {
    
    private static let baseUrl = "https://api.flickr.com/services/rest/"
    private static let key = "9480a18b30ba78893ebd8f25feaabf17"
    
    
    case getPhotos(text: String, page: Int)
    
    private var path: String {
        switch self {
        case .getPhotos(let text, let page):
            return "?method=flickr.photos.search&api_key=\(Router.key)&per_page=10&page=\(page)&format=json&nojsoncallback=1&text=\(text)"
        }
    }
    

    private var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }

    
    func request() throws -> URLRequest {
        var urlString = Router.baseUrl + path
        
        if let urlTextEscaped = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString = urlTextEscaped
        }
        
        guard let url = URL(string: urlString) else { throw ErrorService.incorrectUrl }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)
        
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        request.allHTTPHeaderFields = [HTTPHeaderField.authentication.rawValue: Router.key]
        
        request.httpMethod = method.value
        return request
    }
    
}

