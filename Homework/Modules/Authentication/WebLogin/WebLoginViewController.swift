//
//  WebLoginVC.swift
//  Homework
//
//  Created by Nihad on 12/20/20.
//

import UIKit
import WebKit
import SnapKit

class WebLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7712978"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "wall,friends,photos,groups,likes"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.68")
                ]
                
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
        
        return webView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        configureSubviews()
        configureWebView()
    }
    
    // MARK: - Helpers
    
    func configureSubviews() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
}

extension WebLoginViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        let userID = params["user_id"]
        
        if let token = token, let userID = userID {
            NetworkService.shared.setSession(with: token, and: userID)
        }
        
        let mainTabCtrl = MainTabController()
        mainTabCtrl.modalPresentationStyle = .fullScreen
        present(mainTabCtrl, animated: true, completion: nil)
        
        decisionHandler(.cancel)
    }
}
