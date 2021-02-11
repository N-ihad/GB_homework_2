//
//  NewsFeedViewContro.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import SnapKit

let descr = "asdfasdfa ksdmflka msdlkfma lskdmfl akmsdlfkm alsdmfl amsdlkfm alskdmfl askmdlf masldkfm laskdmfl amsdlf masl asmdflk amsldkmf laskmdfl kamsdlkfm aslkdmf dfa ksdmflka msdlkfma lskdmfl akmsdlfkm alsdmfl amsdlkfm alskdmfl askmdlf masldkfm laskdmfl amsdlf masl asmdflk amsldkmf laskmdfl kamsdlkfm aslkdmf"

class NewsFeedViewController: UIViewController {
    
    // MARK: - Properties
    var posts: [Post] = [Post(authorName: "Test Testov", authorAvatar: UIImage(named: "vk-logo")!, description: descr, image: UIImage(named: "testAvatar1")!),
                         Post(authorName: "Test1 Testov1", authorAvatar: UIImage(named: "vk-logo")!, description: descr, image: UIImage(named: "testAvatar")!),]
    var tableView = UITableView()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "Новости"
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.set(post: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 570
    }
}
