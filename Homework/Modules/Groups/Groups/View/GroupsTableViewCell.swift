//
//  GroupTableViewCell.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {
    
    static let identifier = "GroupsTableViewCell"
    private lazy var avatarImageView = makeAvatarImageView()
    private lazy var titleLabel = makeTitleLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
        configureGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleAvatarTapped() {
        Utilities().animate(viewToAnimate: avatarImageView)
    }
    
    func configureSubviews() {
        self.contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(avatarImageView.snp.right).offset(8)
        }
    }
    
    func configureGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleAvatarTapped))
        self.avatarImageView.addGestureRecognizer(gesture)
    }
    
    func set(groupTitle: String, groupAvatarURL: URL) {
        avatarImageView.kf.setImage(with: groupAvatarURL)
        titleLabel.text = groupTitle
    }
}
