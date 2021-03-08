//
//  Post.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

class Post {
    var authorName: String
    var authorAvatarUrl: URL
    var description: String
    var imageUrl: URL
    var comments: NewsFeedComments
    var likes: NewsFeedLikes
    var reposts: NewsFeedReposts
    
    init(authorName: String,
         authorAvatarUrl: URL,
         description: String,
         imageUrl: URL,
         comments: NewsFeedComments,
         likes: NewsFeedLikes,
         reposts: NewsFeedReposts)
    {
        self.authorName = authorName
        self.authorAvatarUrl = authorAvatarUrl
        self.description = description
        self.imageUrl = imageUrl
        self.comments = comments
        self.likes = likes
        self.reposts = reposts
    }
}
