//
//  PostCell+extension.swift
//  Homework
//
//  Created by Nihad on 2/7/21.
//

import UIKit
import SnapKit

extension PostTableViewCell {
    func makePosterImageView() -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 30 / 2
        iv.backgroundColor = .clear
        iv.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 48, height: 48))
        }
        
        return iv
    }
    
    func makePostDescriptionTextView() -> UITextView {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: UIScreen.main.bounds.width - 30, height: 100))
        }
        tv.allowsEditingTextAttributes = false
        tv.isSelectable = false
        
        return tv
    }
    
    func makePostImageView() -> UIImageView {
        let iv = UIImageView()
        iv.backgroundColor = .vkBlue
        iv.contentMode = .scaleAspectFit
        iv.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 300))
        }
        
        return iv
    }
    
    func makeLikeButton() -> UIButton {
        let img = UIImage(systemName: "heart")!
        let imgFilled = UIImage(systemName: "heart.fill")!
        let btn = Utilities().button(with: .vkBlue, imgForNormalState: img, imgForSelectedState: imgFilled, width: 35, height: 30)
        btn.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        
        return btn
    }
    
    func makeShareButton() -> UIButton {
        let img = UIImage(systemName: "arrowshape.turn.up.left")!
        let imgFilled = UIImage(systemName: "arrowshape.turn.up.left.fill")!
        let btn = Utilities().button(with: .vkBlue, imgForNormalState: img, imgForSelectedState: imgFilled, width: 35, height: 30)
        btn.addTarget(self, action: #selector(handleShareTapped(_:)), for: .touchUpInside)
        
        return btn
    }
    
    func makePostViewsImageView() -> UIImageView {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "eye")
        iv.tintColor = .vkBlue
        
        return iv
    }
    
    func makeCommentButton() -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        btn.tintColor = .vkBlue
        btn.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        
        return btn
    }
    
}
