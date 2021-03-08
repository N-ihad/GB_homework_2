//
//  NewsFeed.swift
//  Homework
//
//  Created by Nihad on 2/11/21.
//

import Foundation

// MARK: - Welcome
struct NewsFeedWelcome: Codable {
    var response: NewsFeedResponse
}

// MARK: - Response
struct NewsFeedResponse: Codable {
    var items: [NewsFeedItem]
    let groups: [NewsFeedGroup]
    let profiles: [NewsFeedProfile]
    let nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case items
        case groups
        case profiles
        case nextFrom = "next_from"
    }
    
    mutating func setPostOwners() {
        for i in 0..<items.count {
            if let userOwner = profiles.first(where: { $0.id == items[i].sourceID }) {
                items[i].userOwner = userOwner
            } else if let groupOwner = groups.first(where: { $0.id == -items[i].sourceID }) {
                items[i].groupOwner = groupOwner
            }
        }
    }
}

// MARK: - Group
struct NewsFeedGroup: Codable {
    let name: String
    let photo200: String?
    let id: Int
    let photo50: String?
    let isAdmin: Int
    let photo100: String?
    let isAdvertiser, isMember: Int
    let type: String
    let isClosed: Int
    let screenName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case photo200 = "photo_200"
        case id
        case photo50 = "photo_50"
        case isAdmin = "is_admin"
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isMember = "is_member"
        case type
        case isClosed = "is_closed"
        case screenName = "screen_name"
    }
}

// MARK: - Item
struct NewsFeedItem: Codable {
    let canSetCategory: Bool
    let markedAsAds, date: Int
    let postType: String
    let postSource: NewsFeedPostSource
    let attachments: [NewsFeedItemAttachment]?
    let reposts: NewsFeedReposts
    let comments: NewsFeedComments
    let text: String
    let likes: NewsFeedLikes
    let type: String
    let postID, sourceID: Int
    let canDoubtCategory: Bool
    let topicID: Int?
    let copyHistory: [NewsFeedCopyHistory]?
    var userOwner: NewsFeedProfile?
    var groupOwner: NewsFeedGroup?

    enum CodingKeys: String, CodingKey {
        case canSetCategory = "can_set_category"
        case markedAsAds = "marked_as_ads"
        case date
        case postType = "post_type"
        case postSource = "post_source"
        case attachments, reposts, comments, text, likes, type
        case postID = "post_id"
        case sourceID = "source_id"
        case canDoubtCategory = "can_doubt_category"
        case topicID = "topic_id"
        case copyHistory = "copy_history"
    }
}

// MARK: - ItemAttachment
struct NewsFeedItemAttachment: Codable {
    let type: String
    let link: NewsFeedLink?
    let photo: NewsFeedPhoto?
}

// MARK: - Link
struct NewsFeedLink: Codable {
    let linkDescription, target: String
    let url: String
    let imageBig: String?
    let title: String
    let imageSrc: String?

    enum CodingKeys: String, CodingKey {
        case linkDescription = "description"
        case target, url
        case imageBig = "image_big"
        case title
        case imageSrc = "image_src"
    }
}

// MARK: - Photo
struct NewsFeedPhoto: Codable {
    let date: Int
    let photo75: String?
    let ownerID, userID: Int
    let photo807: String?
    let text: String
    let postID: Int
    let accessKey: String
    let height, id: Int
    let photo1280: String?
    let albumID: Int
    let photo130, photo2560: String?
    let hasTags: Bool
    let width: Int
    let photo604: String?

    enum CodingKeys: String, CodingKey {
        case date
        case photo75 = "photo_75"
        case ownerID = "owner_id"
        case userID = "user_id"
        case photo807 = "photo_807"
        case text
        case postID = "post_id"
        case accessKey = "access_key"
        case height, id
        case photo1280 = "photo_1280"
        case albumID = "album_id"
        case photo130 = "photo_130"
        case photo2560 = "photo_2560"
        case hasTags = "has_tags"
        case width
        case photo604 = "photo_604"
    }
}

// MARK: - Comments
struct NewsFeedComments: Codable {
    let count, canPost: Int

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - CopyHistory
struct NewsFeedCopyHistory: Codable {
    let ownerID: Int
    let postType: String
    let fromID, date, id: Int
    let postSource: NewsFeedPostSource
    let attachments: [NewsFeedCopyHistoryAttachment]
    let text: String

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case postType = "post_type"
        case fromID = "from_id"
        case date, id
        case postSource = "post_source"
        case attachments, text
    }
}

// MARK: - CopyHistoryAttachment
struct NewsFeedCopyHistoryAttachment: Codable {
    let type: String
    let photo: NewsFeedPhoto
}

// MARK: - PostSource
struct NewsFeedPostSource: Codable {
    let type: String
}

// MARK: - Likes
struct NewsFeedLikes: Codable {
    let count, userLikes, canLike, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - Reposts
struct NewsFeedReposts: Codable {
    let userReposted, count: Int

    enum CodingKeys: String, CodingKey {
        case userReposted = "user_reposted"
        case count
    }
}

// MARK: - Profile
struct NewsFeedProfile: Codable {
    let firstName: String
    let online: Int
    let photo50: String?
    let lastName: String
    let photo100: String?
    let onlineInfo: NewsFeedOnlineInfo
    let sex, id: Int
    let screenName: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case online
        case photo50 = "photo_50"
        case lastName = "last_name"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case sex, id
        case screenName = "screen_name"
    }
}

// MARK: - OnlineInfo
struct NewsFeedOnlineInfo: Codable {
    let isOnline, visible, isMobile: Bool?
    let lastSeen: Int?

    enum CodingKeys: String, CodingKey {
        case isOnline = "is_online"
        case visible
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
    }
}
