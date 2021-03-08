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
    
    private var refreshControl = UIRefreshControl()
    private var token: Any?
    
    var tableView = UITableView()
    private var viewModel: FriendsTableViewProtocol = FriendsTableViewViewModel()
    
    lazy var loadingView = makeLoadingView()
    lazy var spinnerIndicatorView = makeSpinnerIndicatorView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigationBar()
        configureTableView()
        configureUI()
        configureRefreshControl()
        populateTableView()
        subscribeToRealmDBChanges()
    }
    
    // MARK: - Selectors
    
    @objc func updateTableViewData() {
        startLoadingAnimation()
        refreshControl.beginRefreshing()
        viewModel.updateUserFriendsData {
            self.tableView.reloadData()
            self.stopLoadingAnimation()
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Helpers
    
    func subscribeToRealmDBChanges() {
//        token = BackendService.shared.realm.objects(User.self).observe {  (changes) in
//                    switch changes {
//                    case let .initial(results):
//                        self.friends = Array(results)
//                    case let .update(results, _, _, _):
//                        self.friends = Array(results)
//                    case .error(let error):
//                        print("DEBUG: error - \(error)")
//                    }
//                }
    }
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(updateTableViewData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func populateTableView() {
        startLoadingAnimation()
        viewModel.fetchUserFriends {
            self.tableView.reloadData()
            self.stopLoadingAnimation()
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier) as! FriendsTableViewCell
        cell.set(viewModel: viewModel.cellViewModel(for: indexPath))
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.getSortedFriendsFirstLettersOfLastName()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendDetailsCollectionVC = PhotosCollectionViewController()
        friendDetailsCollectionVC.userID = viewModel.getUserID(for: indexPath)
        navigationController?.pushViewController(friendDetailsCollectionVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Transition

extension FriendsViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return FriendsAnimationController(animationDuration: 1, animationType: .push)
        case .pop:
            return FriendsAnimationController(animationDuration: 1, animationType: .pop)
        default:
            return nil
        }
    }
}
