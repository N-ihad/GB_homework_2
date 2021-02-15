//
//  PhotosTableViewCell+extension.swift
//  Homework
//
//  Created by Nihad on 1/26/21.
//

import UIKit

extension PhotosTableViewCell {
    
    func makePhotoImageView() -> UIImageView {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFit
        
        return photoImageView
    }
    
}
