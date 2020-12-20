//
//  Utilities.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = image
        iv.tintColor = .white
        
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8, width: 28, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.3)
        
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
        btn.setDimensions(width: CGFloat(width), height: CGFloat(height))
        
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
