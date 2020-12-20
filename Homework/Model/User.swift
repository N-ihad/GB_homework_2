//
//  User.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

class User: PosterProtocol {
    struct alphabeticDictionaryOfUsersLastnames {
        static var dict = [String: [User]]()
        static var keys = Array(dict.keys)
        
        static func getUsersByIndex(key: Int) -> [User] {
            return dict[keys[key]]!
        }
    }
    var name: String
    var avatar: UIImage
    var photos: [UIImage]
    static var allUsersSortedByName = [User]()
    
    init(name: String, avatar: UIImage, photos: [UIImage]) {
        self.name = name
        self.avatar = avatar
        self.photos = photos
        
        User.allUsersSortedByName.append(self)
        User.allUsersSortedByName.sort(by: { $0.name > $1.name })
        User.updateDictionaryOfLastnames(with: self)
        User.alphabeticDictionaryOfUsersLastnames.keys = Array(User.alphabeticDictionaryOfUsersLastnames.dict.keys).sorted(by: <)
    }
    
    static func updateDictionaryOfLastnames(with user: User) {
        let fullname = user.name.components(separatedBy: " ")
        let lastname = fullname[1]
        let firstLetterOfLastName = lastname[0]
        alphabeticDictionaryOfUsersLastnames.dict[firstLetterOfLastName, default: [User]()].append(user)
    }
}

