//
//  Post.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

class Post {
    var authorName: String
    var authorAvatar: UIImage
    var description: String
    var image: UIImage
    
    init(authorName: String, authorAvatar: UIImage, description: String, image: UIImage) {
        self.authorName = authorName
        self.authorAvatar = authorAvatar
        self.description = description
        self.image = image
    }
}
