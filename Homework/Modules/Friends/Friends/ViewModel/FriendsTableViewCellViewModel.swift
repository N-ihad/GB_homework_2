//
//  FriendsTableViewCellViewModel.swift
//  Homework
//
//  Created by Nihad on 1/28/21.
//

import Foundation

protocol FriendsTableViewCellViewModelProtocol {
    var username: String { get set }
    var userAvatarURL: URL { get set }
}

class FriendsTableViewCellViewModel {
    
    var username: String
    var userAvatarURL: URL
    
    init(friend: User) {
        username = "\(friend.firstName) \(friend.lastName)"
        userAvatarURL = URL(string: friend.photo100) ?? URL(string: "")!
    }
    
}

extension FriendsTableViewCellViewModel: FriendsTableViewCellViewModelProtocol {
    
    
}
