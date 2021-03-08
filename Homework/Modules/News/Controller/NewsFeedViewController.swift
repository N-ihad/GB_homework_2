//
//  NewsFeedViewContro.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import SnapKit
import Kingfisher

class NewsFeedViewController: UIViewController {
    
    // MARK: - Properties
    var posts: [NewsFeedItem]? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    var tableView = UITableView()
    lazy var loadingView = makeLoadingView()
    lazy var spinnerIndicatorView = makeSpinnerIndicatorView()
    private var refreshControl = UIRefreshControl()
    private var nextFrom = ""
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureRefreshControl()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(getPosts), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func configureUI() {
        navigationItem.title = "Новости"
        
        configureTableView()
        getPosts()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.prefetchDataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func getPosts() {
        startLoadingAnimation()
        NetworkService.shared.getUserNewsFeed(of: .post) { response in
            guard let response = response else { return }
            self.posts = response.items
            self.stopLoadingAnimation()
            self.refreshControl.endRefreshing()
            self.nextFrom = response.nextFrom
        }
    }
    
    func loadMorePosts() {
        startLoadingAnimation()
        NetworkService.shared.getUserNewsFeed(of: .post, startingFrom: nextFrom) { response in
            guard let response = response else { return }
            self.posts?.append(contentsOf: response.items)
            self.stopLoadingAnimation()
            self.refreshControl.endRefreshing()
            self.nextFrom = response.nextFrom
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !spinnerIndicatorView.isAnimating {
            loadMorePosts()
        }
    }
    
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = posts else { return 0 }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let posts = posts else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
        let post = posts[indexPath.row]

        var authorName: String = ""
        var authorImage: String = ""
        
        if let userOwner = post.userOwner {
            authorName = userOwner.firstName + " " + userOwner.lastName
            authorImage = userOwner.photo50 ?? "https://lh3.googleusercontent.com/proxy/U-xvedGMfn3qV3jseDCdBZdH-E2Rc8ODjSJRZXeuAh49eGwBGW_wPQVJkpgWOxKSWQ3k1A37wQXamizlFF3yGuM0GWHT"
        } else if let groupOwner = post.groupOwner {
            authorName = groupOwner.name
            authorImage = groupOwner.photo50 ?? "https://lh3.googleusercontent.com/proxy/U-xvedGMfn3qV3jseDCdBZdH-E2Rc8ODjSJRZXeuAh49eGwBGW_wPQVJkpgWOxKSWQ3k1A37wQXamizlFF3yGuM0GWHT"
        }
        
        let posterImageUrl = URL(string: authorImage)
        let postImageUrl = URL(string: post.attachments?.first?.photo?.photo75 ?? "")
        cell.set(post: Post(
            authorName: authorName,
            authorAvatarUrl: posterImageUrl!,
            description: post.text,
            imageUrl: postImageUrl ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png")!,
            comments: post.comments,
            likes: post.likes,
            reposts: post.reposts
        ))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 570
    }
}

extension NewsFeedViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    
  }
}
