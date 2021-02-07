//
//  GroupNew.swift
//  Homework
//
//  Created by Nihad on 12/25/20.
//

import Foundation
import RealmSwift

class GroupsResponse: Decodable {
    let response: Groups
}

class Groups: Decodable {
    let count: Int
    let items: [Group]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
}

class Group: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name, screenName: String
    @objc dynamic var isClosed: Int
    @objc dynamic var type: String
    @objc dynamic var isAdmin, isMember, isAdvertiser: Int
    @objc dynamic var photo50, photo100, photo200: String

    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}
