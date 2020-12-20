//
//  GroupsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

class GroupsVC: UIViewController {
    
    // MARK: - Properties
    var groups: [Group] = [Group(name: "KFC", avatar: UIImage(named: "group1")!),
                           Group(name: "Something", avatar: UIImage(named: "group3")!),
                           Group(name: "Travelling", avatar: UIImage(named: "group5")!)]
    var tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredData = [Group]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredData = groups
        transitioningDelegate = self
        navigationController?.delegate = self
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleGlobalTapped() {
        let globalGroupsVC = GlobalGroupsVC()
        navigationController?.pushViewController(globalGroupsVC, animated: true)
    }
    
    @objc func goBack() {
        print("DEBUG: triggered from left!!")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "Группы"
        
        configureNavigationBar()
        configureSearchBar()
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Глобальные", style: .plain, target: self, action: #selector(handleGlobalTapped))
        navigationController?.navigationBar.tintColor = .vkBlue
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(GroupCell.self, forCellReuseIdentifier: "GroupCell")
        tableView.pinTo(view)
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
}


extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! GroupCell
        
        let group = filteredData[indexPath.row]
        cell.set(group: group)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && !searchController.searchBar.isFirstResponder {
            self.groups.remove(at: indexPath.row)
            self.filteredData.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension GroupsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = groups
            tableView.reloadData()
        } else {
            for group in groups {
                if group.name.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(group)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        filteredData = groups
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filteredData = groups
    }
}

extension GroupsVC: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return AnimationControllerForGroups(animationDuration: 1, animationType: .pop)
        default:
            return nil
        }
    }
}
