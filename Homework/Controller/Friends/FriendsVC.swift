//
//  FriendsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

var friends: [User]!
var indPath: IndexPath!

class FriendsVC: UIViewController {
    // MARK: - Properties
    //    var friends: [User] = [User(name: "Sarah Clark", avatar: UIImage(named: "testAvatar")!, photos: [UIImage(named: "friend1photo")!, UIImage(named: "friend1photo1")!, UIImage(named: "friend1photo2")!]),
    //                           User(name: "Jakaria Joe", avatar: UIImage(named: "testAvatar1")!, photos: [UIImage(named: "friend2photo")!, UIImage(named: "friend2photo1")!, UIImage(named: "friend2photo2")!]),
    //                           User(name: "Lock Json", avatar: UIImage(named: "testAvatar2")!, photos: [UIImage(named: "friend3photo2")!, UIImage(named: "friend3photo3")!, UIImage(named: "friend3photo4")!])]
    var tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredData = [User]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friends = [User(name: "Sarah Clark", avatar: UIImage(named: "testAvatar")!, photos: [UIImage(named: "friend1photo")!, UIImage(named: "friend1photo1")!, UIImage(named: "friend1photo2")!]),
                   User(name: "Jakaria Joe", avatar: UIImage(named: "testAvatar1")!, photos: [UIImage(named: "friend2photo")!, UIImage(named: "friend2photo1")!, UIImage(named: "friend2photo2")!]),
                   User(name: "Lock Json", avatar: UIImage(named: "testAvatar2")!, photos: [UIImage(named: "friend3photo2")!, UIImage(named: "friend3photo3")!, UIImage(named: "friend3photo4")!])]
        filteredData = User.allUsersSortedByName
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleLoadingTapped(_ sender: UIBarButtonItem) {
        startLoadingAnimation()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        transitioningDelegate = self
        navigationController?.delegate = self
        configureNavigationBar()
        configureSearchBar()
        configureTableView()
    }
    
    func configureNavigationBar() {
        let imageView = UIImageView(image: UIImage(named: "vk-logo"))
        imageView.contentMode = .scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "dot.circle.and.cursorarrow"), style: .plain, target: self, action: #selector(handleLoadingTapped))
        navigationController?.navigationBar.tintColor = .vkBlue
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        tableView.pinTo(view)
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    func startLoadingAnimation() {
        let lay = CAReplicatorLayer()
        lay.frame = CGRect(x: -10, y: 0, width: 100, height: 10)
        let circle = CALayer()
        circle.frame = CGRect(x: -10, y: 0, width: 10, height: 10)
        circle.backgroundColor = UIColor.gray.cgColor
        circle.cornerRadius = 10 / 2
        lay.addSublayer(circle)
        lay.instanceCount = 3
        lay.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        
        let v = UIView()
        v.backgroundColor = .black
        v.layer.addSublayer(lay)
        view.addSubview(v)
        v.center(inView: view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            lay.removeFromSuperlayer()
        }
    }
}

// MARK: - TableView

extension FriendsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchController.searchBar.isFirstResponder ? 1 : User.alphabeticDictionaryOfUsersLastnames.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.searchBar.isFirstResponder ? filteredData.count : User.alphabeticDictionaryOfUsersLastnames.getUsersByIndex(key: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchController.searchBar.isFirstResponder ? "Found" : User.alphabeticDictionaryOfUsersLastnames.keys[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        var user: User!
        if searchController.searchBar.isFirstResponder {
            user = filteredData[indexPath.row]
        } else {
            user = User.alphabeticDictionaryOfUsersLastnames.getUsersByIndex(key: indexPath.section)[indexPath.row]
        }
        cell.set(user: user)
        cell.delegate = self
        indPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendCellDetailsCollectionVC = FriendDetailsCollectionVC()
        navigationController?.pushViewController(friendCellDetailsCollectionVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchController

extension FriendsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = User.allUsersSortedByName
            tableView.reloadData()
        } else {
            for user in User.allUsersSortedByName {
                if user.name.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(user)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        filteredData = []
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filteredData = []
    }
}

// MARK: - Friend Cell Delegate Methods

extension FriendsVC: FriendCellDelegate {
    func handleLikeTapped(_ cell: FriendCell) {
        
    }
    
    func handleFavouriteTapped(_ cell: FriendCell) {
        
    }
    
    func handleFriendAvatarTapped(_ cell: FriendCell) {
        
    }
}

// MARK: - Transition

extension FriendsVC: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return AnimationController(animationDuration: 1, animationType: .push)
        case .pop:
            return AnimationController(animationDuration: 1, animationType: .pop)
        default:
            return nil
        }
    }
}
