//
//  SearchCellViewModel.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import Foundation

struct SearchCellViewModel {
    private let id: String
    private let secret: String
    private let server: String
    private let farm: Int
    
    let title: String
    
    var imagePath: String {
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    init(photo: Photo) {
        self.title = photo.title
        self.secret = photo.secret
        self.server = photo.server
        self.farm = photo.farm
        self.id = photo.id
    }
    
}
