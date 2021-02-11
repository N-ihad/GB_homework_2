//
//  GlobalGroupsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit
import SnapKit

class GlobalGroupsViewController: UIViewController {
    
    var groups: [Group] = []
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureGestures()
    }
    
    @objc func handleCancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureUI() {
        navigationItem.title = "Глобальные группы"
        
        configureNavigationBar()
        configureTableView()
    }
    
    func configureGestures() {
        let screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(goBack))
        screenEdgeRecognizer.edges = .left
        view.addGestureRecognizer(screenEdgeRecognizer)
    }
    
    func configureNavigationBar() {
        self.tableView.sectionHeaderHeight = 300
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

extension GlobalGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.identifier) as! GroupsTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
