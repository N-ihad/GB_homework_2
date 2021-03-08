//
//  GroupsTableViewCell+extension.swift
//  Homework
//
//  Created by Nihad on 1/26/21.
//

import UIKit
import SnapKit

extension GroupsTableViewCell {
    
    func makeAvatarImageView() -> UIImageView {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 48 / 2
        avatarImageView.backgroundColor = .vkBlue
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 48, height: 48))
        }
        
        return avatarImageView
    }
    
    func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width/2)
        }
        
        return titleLabel
    }
}
