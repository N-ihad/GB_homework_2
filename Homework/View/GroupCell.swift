//
//  GroupTableViewCell.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

class GroupCell: UITableViewCell {
    // MARK: - Properties
    let groupImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .vkBlue
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let groupTitleLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func handleAvatarTapped() {
        Utilities().animate(viewToAnimate: groupImageView)
    }
    
    // MARK: - Helpers
    func configureUI() {
        self.contentView.addSubview(groupImageView)
        self.contentView.addSubview(groupTitleLabel)
        groupImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        groupTitleLabel.centerY(inView: self, leftAnchor: groupImageView.rightAnchor, paddingLeft: 8)
    }
    
    func configureGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleAvatarTapped))
        self.groupImageView.addGestureRecognizer(gesture)
    }
    
    func set(group: Group) {
        groupImageView.image = group.avatar
        groupTitleLabel.text = group.name
    }
}
