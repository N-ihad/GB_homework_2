//
//  Utilities.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import SnapKit

class Utilities {
    
    func counterLabel() -> UILabel {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        return lbl
    }
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white
        
        view.addSubview(iv)
        iv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.size.equalTo(CGSize(width: 28, height: 24))
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalTo(iv.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(8)
        }
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0.3)
        }
        
        return view
    }
    
    func textField(withPlacehilder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }
    
    func button(with color: UIColor, imgForNormalState: UIImage, imgForSelectedState: UIImage, width: Int, height: Int) -> UIButton {
        let btn = UIButton()
        let img = imgForNormalState.imageWith(newSize: CGSize(width: 100, height: 100), color: UIColor.vkBlue)
        let imgFilled = imgForSelectedState.imageWith(newSize: CGSize(width: 100, height: 100), color: UIColor.vkBlue)
        btn.setImage(img, for: .normal)
        btn.setImage(imgFilled, for: .selected)
        btn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: width, height: height))
        }
        
        return btn
    }
    
    func divider(color: UIColor) -> UIView {
        let v = UIView()
        v.backgroundColor = .gray
        v.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        v.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        return v
    }
    
    func animate(viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
}
