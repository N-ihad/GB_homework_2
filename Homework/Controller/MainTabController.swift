//
//  MainTabController.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import Alamofire

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        testRequests()
    }

    // MARK: - Helpers
    
    func configureViewControllers() {
        let friendsVC  = FriendsVC()
        let friendsNav = templateNavigationController(image: UIImage(named: "person.3")!, rootViewController: friendsVC)
        
        let groupsVC = GroupsVC()
        let groupsNav = templateNavigationController(image: UIImage(named: "list.bullet.indent")!, rootViewController: groupsVC)
        
        let newsVC = NewsVC()
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
//        getUserFriends()
//        getPhotosOfUser(with: Session.shared.userID)
//        getUserGroups()
//        getGroups(with: "Fashion")
    }
    
    func getUserFriends() {
        let request = AF.request("https://api.vk.com/method/friends.get?user_id=\(Session.shared.userID)&v=5.28&access_token=\(Session.shared.token)")
        request.responseJSON { (data) in
            print(data.result)
        }
    }
    
    func getPhotosOfUser(with userID: String) {
        let request = AF.request("https://api.vk.com/method/photos.get?owner_id=\(userID)&album_id=profile&v=5.28&access_token=\(Session.shared.token)")
        request.responseJSON { (data) in
            print(data.result)
        }
    }
    
    func getUserGroups() {
        let request = AF.request("https://api.vk.com/method/groups.get?user_id=\(Session.shared.userID)&v=5.28&access_token=\(Session.shared.token)")
        request.responseJSON { (data) in
            print(data.result)
        }
    }
    
    func getGroups(with title: String) {
        let request = AF.request("https://api.vk.com/method/groups.search?q=\(title)&v=5.28&access_token=\(Session.shared.token)")
        request.responseJSON { (data) in
            print(data.result)
        }
    }
    
}

