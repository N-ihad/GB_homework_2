//
//  GroupsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import SnapKit

class GroupsViewController: UIViewController {
    
    // MARK: - Properties
    var groups: [Group]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var tableView = UITableView()
    var token: Any?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        navigationController?.delegate = self
        
        configureUI()
        fetchUserGroups()
        subscribeToRealmDBChanges()
    }
    
    // MARK: - Selectors
    
    @objc func handleGlobalTapped() {
        let globalGroupsVC = GlobalGroupsViewController()
        navigationController?.pushViewController(globalGroupsVC, animated: true)
    }
    
    // MARK: - Helpers
    
    func subscribeToRealmDBChanges() {
        token = BackendService.shared.realm.objects(Group.self).observe {  (changes) in
                    switch changes {
                    case let .initial(results):
                        self.groups = Array(results)
                    case let .update(results, _, _, _):
                        self.groups = Array(results)
                    case .error(let error):
                        print("DEBUG: error - \(error)")
                    }
                }
    }
    
    func fetchUserGroups() {
        BackendService.shared.getUserGroups { groups in
            self.groups = groups
        }
    }
    
    func configureUI() {
        navigationItem.title = "Группы"
        
        configureNavigationBar()
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
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - UITableViewDelegate / UITableViewDataSource

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.identifier) as! GroupsTableViewCell
        guard let groups = groups else { return cell }
        let group = groups[indexPath.row]
        cell.set(groupTitle: group.name, groupAvatarURL: URL(string: group.photo50) ?? URL(string: "")!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.groups?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate / UINavigationControllerDelegate

extension GroupsViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return GroupsAnimationController(animationDuration: 1, animationType: .pop)
        default:
            return nil
        }
    }
}
