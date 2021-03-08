//
//  NewsFeedViewController+UI.swift
//  Homework
//
//  Created by Nihad on 3/8/21.
//

import UIKit
import SnapKit

extension NewsFeedViewController {
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
