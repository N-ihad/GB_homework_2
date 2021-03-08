//
//  FriendPhotosCell.swift
//  Eigth_homework_task
//
//  Created by Nihad on 11/23/20.
//

import UIKit
import SnapKit

class PhotosTableViewCell: UICollectionViewCell {
    
    static let identifier = "PhotosTableViewCell"
    lazy var photoImageView = makePhotoImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.bottom.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}
