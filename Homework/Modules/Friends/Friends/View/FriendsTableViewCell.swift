//
//  FriendCell.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import SnapKit

class FriendsTableViewCell: UITableViewCell {
    
    static let identifier = "FriendCell"
    private lazy var avatarImageView = makeAvatarImageView()
    private lazy var avatarView = makeAvatarView()
    private let friendNameLabel: UILabel = {
        let friendNameLabel = UILabel()
        friendNameLabel.backgroundColor = .white
        
        return friendNameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: FriendsTableViewCellViewModelProtocol) {
        avatarImageView.kf.setImage(with: viewModel.userAvatarURL)
        friendNameLabel.text = viewModel.username
    }
    
    func configureSubviews() {
        avatarView.addSubview(avatarImageView)
        contentView.addSubview(avatarView)
        contentView.addSubview(friendNameLabel)
        
        avatarView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        friendNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(avatarView.snp.right).offset(10)
        }
    }
}
