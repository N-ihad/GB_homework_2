//
//  Photo.swift
//  Homework
//
//  Created by Nihad on 12/25/20.
//

import Foundation
import RealmSwift

class PhotosResponse: Decodable {
    let response: Photos
}

class Photos: Decodable {
    let count: Int
    let items: [Photo]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
}

class Photo: Object, Decodable {
    @objc dynamic var albumID, date, id, ownerID: Int
    @objc dynamic var hasTags: Bool
    @objc dynamic var height: Int
    @objc dynamic var photo1280, photo130, photo604, photo75: String?
    @objc dynamic var photo807: String?
    @objc dynamic var postID: Int = -1
    @objc dynamic var text: String
    @objc dynamic var width: Int
    @objc dynamic var photo2560: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case height
        case photo1280 = "photo_1280"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo75 = "photo_75"
        case photo807 = "photo_807"
        case postID = "post_id"
        case text, width
        case photo2560 = "photo_2560"
    }
}
