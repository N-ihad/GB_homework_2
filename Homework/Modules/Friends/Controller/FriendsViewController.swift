//
//  FriendsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import Kingfisher

class FriendsViewController: UIViewController {
    
    // MARK: - Properties
    
    var refreshControl = UIRefreshControl()
    var token: Any?
    
    var tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredData = [User]()
    let loadingOverlay = Utilities().loadingView()
    
    var friends: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                self.configureSections()
                self.tableView.reloadData()
                self.stopLoadingAnimation()
            }
        }
    }
    var sortedFirstLetters: [String] = []
    var sections: [[User]] = [[]]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigationBar()
        configureSearchBar()
        configureTableView()
        configureUI()
        configureRefreshControl()
        fetchUserFriends()
        subscribeToRealmDBChanges()
    }
    
    // MARK: - Selectors
    
    @objc func updateTableViewData() {
        BackendService.shared.getUserFriends(update: true) { friends in
            self.friends = friends
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - Helpers
    
    func subscribeToRealmDBChanges() {
        token = BackendService.shared.realm.objects(User.self).observe {  (changes) in
                    switch changes {
                    case let .initial(results):
                        print("DEBUG: results - \(Array(results))")
                        self.friends = Array(results)
                    case let .update(results, _, _, _):
                        print("DEBUG: results (update) - \(results)")
                        self.friends = Array(results)
                    case .error(let error):
                        print("DEBUG: error - \(error)")
                    }
                    print("DEBUG: Users data has been changed")
                }
    }
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(updateTableViewData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func configureSections() {
        let firstLetters = friends.map { $0.titleFirstLetter }
        let uniqueFirstLetters = Array(Set(firstLetters))

        sortedFirstLetters = uniqueFirstLetters.sorted()
        sections = sortedFirstLetters.map { firstLetter in
            return friends
                .filter { $0.titleFirstLetter == firstLetter }
                .sorted { $0.lastName < $1.lastName }
        }
    }
    
    func fetchUserFriends() {
        startLoadingAnimation()
        BackendService.shared.getUserFriends(update: false) { friends in
            self.friends = friends
            self.configureSections()
            self.tableView.reloadData()
            self.stopLoadingAnimation()
        }
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
        searchController.searchBar.isUserInteractionEnabled = false
        searchController.searchBar.placeholder = "Needs modifying for new data model"
    }
    
    func startLoadingAnimation() {
        view.addSubview(loadingOverlay)
        loadingOverlay.pinTo(view)
    }
    
    func stopLoadingAnimation() {
        loadingOverlay.removeFromSuperview()
    }
}

// MARK: - TableView

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
//        return searchController.searchBar.isFirstResponder ? 1 : User.alphabeticDictionaryOfUsersLastnames.keys.count
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchController.searchBar.isFirstResponder ? filteredData.count : User.alphabeticDictionaryOfUsersLastnames.getUsersByIndex(key: section).count
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return searchController.searchBar.isFirstResponder ? "Found" : User.alphabeticDictionaryOfUsersLastnames.keys[section]
        guard !sortedFirstLetters.isEmpty else { return "Loading.." } // sortedFirstLetters is empty
        return searchController.searchBar.isFirstResponder ? "Search is yet to be developed" : sortedFirstLetters[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
//        var user: User!
//        if searchController.searchBar.isFirstResponder {
//            user = filteredData[indexPath.row]
//        } else {
//            user = User.alphabeticDictionaryOfUsersLastnames.getUsersByIndex(key: indexPath.section)[indexPath.row]
//        }
        let user = sections[indexPath.section][indexPath.row]
        cell.set(username: user.firstName + " " + user.lastName, userAvatarURL: URL(string: user.photo100) ?? URL(string: "")!)
        cell.delegate = self
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedFirstLetters
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendDetailsCollectionVC = FriendPhotosCollectionViewController()
        friendDetailsCollectionVC.user = sections[indexPath.section][indexPath.row]
        navigationController?.pushViewController(friendDetailsCollectionVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchController

extension FriendsViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredData = []
//
//        if searchText == "" {
//            filteredData = User.allUsersSortedByName
//            tableView.reloadData()
//        } else {
//            for user in User.allUsersSortedByName {
//                if user.name.lowercased().contains(searchText.lowercased()) {
//                    filteredData.append(user)
//                }
//            }
//        }
//
//        tableView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.endEditing(true)
//        filteredData = []
//        tableView.reloadData()
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        filteredData = []
//    }
}

// MARK: - Friend Cell Delegate Methods

extension FriendsViewController: FriendCellDelegate {
    func handleLikeTapped(_ cell: FriendCell) {
        
    }
    
    func handleFavouriteTapped(_ cell: FriendCell) {
        
    }
    
    func handleFriendAvatarTapped(_ cell: FriendCell) {
        
    }
}

// MARK: - Transition

extension FriendsViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
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
