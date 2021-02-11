//
//  FriendTableViewCell+extension.swift
//  Homework
//
//  Created by Nihad on 1/25/21.
//

import UIKit
import SnapKit

extension FriendsTableViewCell {

    func makeAvatarImageView() -> UIImageView {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 48 / 2
        avatarImageView.backgroundColor = .vkBlue
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 48, height: 48))
        }
        
        return avatarImageView
    }
    
    func makeAvatarView() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 48, height: 48))
        }
        
        let shadowView = UIView()
        shadowView.layer.cornerRadius = 48 / 2
        shadowView.backgroundColor = .vkBlue
        shadowView.dropShadow()
        shadowView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 48, height: 48))
        }
        
        containerView.addSubview(shadowView)
        
        return containerView
    }
    
}
