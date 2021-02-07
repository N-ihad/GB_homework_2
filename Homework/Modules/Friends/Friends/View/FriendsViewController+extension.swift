//
//  FriendsViewController+extension.swift
//  Homework
//
//  Created by Nihad on 1/26/21.
//

import UIKit
import SnapKit

extension FriendsViewController {
    func makeLoadingView() -> UIView {
        let loadingView = UIView()
        loadingView.backgroundColor = .black
        loadingView.alpha = 0.7
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 80, height: 60))
        }
        
        return loadingView
    }
    
    func makeSpinnerIndicatorView() -> UIActivityIndicatorView {
        let spinnerIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinnerIndicatorView.color = .white
        
        return spinnerIndicatorView
    }
    
    func configureUI() {
        tableView.sectionIndexColor = .vkBlue
        transitioningDelegate = self
        navigationController?.delegate = self
    }
    
    func configureNavigationBar() {
        let imageView = UIImageView(image: UIImage(named: "vk-logo"))
        imageView.contentMode = .scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView
        navigationController?.navigationBar.tintColor = .vkBlue
    }
    
    func startLoadingAnimation() {
        tableView.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-70)
        }

        loadingView.addSubview(spinnerIndicatorView)
        spinnerIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        spinnerIndicatorView.startAnimating()
    }

    func stopLoadingAnimation() {
        spinnerIndicatorView.stopAnimating()
        loadingView.removeFromSuperview()
    }
    
}
