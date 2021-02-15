//
//  MainTabController.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import Alamofire

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let documentsPath = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)
                                                        .first?.path {
                print("DEBUG: documents Directory - \(documentsPath)")
        }
        
        fetchUserNewsFeed()

        configureViewControllers()
        testRequests()
    }

    // MARK: - Helpers
    
    func fetchUserNewsFeed() {
        DispatchQueue.global().async {
            NetworkService.shared.getUserNewsFeed(of: .post) { response in
                guard let res = response.value else { return }
                let _ = res.response.items
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func configureViewControllers() {
        let friendsVC  = FriendsViewController()
        let friendsNav = templateNavigationController(image: UIImage(named: "person.3")!, rootViewController: friendsVC)
        
        let groupsVC = GroupsViewController()
        let groupsNav = templateNavigationController(image: UIImage(named: "list.bullet.indent")!, rootViewController: groupsVC)
        
        let newsVC = NewsFeedViewController()
        let newsNav = templateNavigationController(image: UIImage(named: "newspaper")!, rootViewController: newsVC)
        
        viewControllers = [friendsNav, groupsNav, newsNav]
    }
    
    func templateNavigationController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let navCtrl = UINavigationController(rootViewController: rootViewController)
        navCtrl.tabBarItem.image = image
        navCtrl.navigationBar.barTintColor = .white
        return navCtrl
    }
    
    // MARK: - Requests
    
    func testRequests() {
        
    }
    
}

