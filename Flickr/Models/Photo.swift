//
//  Photo.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
}
