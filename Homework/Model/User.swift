//
//  UserNew.swift
//  Homework
//
//  Created by Nihad on 12/24/20.
//

import Foundation
import RealmSwift

class UsersResponse: Decodable {
    let response: Users
}

class Users: Decodable {
    let count: Int
    let items: [User]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
}


class User: Object, Decodable {
    @objc dynamic var firstName: String
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    @objc dynamic var photo50, photo100, photo200_Orig: String
    @objc dynamic var trackCode: String
    @objc dynamic var deactivated: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200_Orig = "photo_200_orig"
        case trackCode = "track_code"
        case deactivated
    }
}


extension User {
    @objc dynamic var titleFirstLetter: String {
        return String(self.lastName[self.lastName.startIndex]).uppercased()
    }
}
