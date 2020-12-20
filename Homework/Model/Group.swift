//
//  Group.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

class Group: PosterProtocol {
    var name: String
    var avatar: UIImage
    
    init(name: String, avatar: UIImage) {
        self.name = name
        self.avatar = avatar
    }
}
