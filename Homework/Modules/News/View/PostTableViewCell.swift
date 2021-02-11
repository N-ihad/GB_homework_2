//
//  PostTableViewCell.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

protocol PostTableViewCellProtocol: class {
    func handleLikeTapped(_ cell: PostTableViewCell)
    func handleShareTapped(_ cell: PostTableViewCell)
    func handleCommentTapped(_ cell: PostTableViewCell)
}

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: PostTableViewCellProtocol?
    private lazy var posterImageView = makePosterImageView()
    private lazy var posterNameLabel = UILabel()
    private lazy var postDescriptionTextView = makePostDescriptionTextView()
    private lazy var postImageView = makePostImageView()
    private lazy var headerDividerView = Utilities().divider(color: UIColor.gray)
    private lazy var footerDividerView = Utilities().divider(color: UIColor.gray)
    private lazy var likeButton = makeLikeButton()
    private lazy var likesCountLabel = Utilities().counterLabel()
    private lazy var shareButton = makeShareButton()
    private lazy var sharesCountLabel = Utilities().counterLabel()
    private lazy var postViewsImageView = makePostViewsImageView()
    private lazy var postViewsCountLabel = Utilities().counterLabel()
    private lazy var commentButton = makeCommentButton()
    private lazy var commentsCountLabel = Utilities().counterLabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLikeTapped(_ sender: UIButton) {
        if sender.isSelected {
            likesCountLabel.text = String(Int(likesCountLabel.text!)! - 1)
        } else {
            likesCountLabel.text = String(Int(likesCountLabel.text!)! + 1)
        }
        sender.isSelected = !sender.isSelected
        delegate?.handleLikeTapped(self)
    }
    
    @objc func handleShareTapped(_ sender: UIButton) {
        if sender.isSelected {
            sharesCountLabel.text = String(Int(sharesCountLabel.text!)! - 1)
        } else {
            sharesCountLabel.text = String(Int(sharesCountLabel.text!)! + 1)
        }
        sender.isSelected = !sender.isSelected
        delegate?.handleShareTapped(self)
    }
    
    @objc func handleCommentTapped() {
        delegate?.handleCommentTapped(self)
    }
    
    // MARK: - Helpers
    
    func set(post: Post) {
        posterImageView.image = post.authorAvatar
        posterNameLabel.text = post.authorName
        postDescriptionTextView.text = post.description
        postImageView.image = post.image
    }
    
    func configureUI() {
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
        }
        
        contentView.addSubview(posterNameLabel)
        posterNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(posterImageView)
            make.left.equalTo(posterImageView.snp.right).offset(12)
        }
        
        contentView.addSubview(headerDividerView)
        headerDividerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
        }
        
        contentView.addSubview(postDescriptionTextView)
        postDescriptionTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerDividerView.snp.bottom).offset(8)
        }
        
        contentView.addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(postDescriptionTextView.snp.bottom).offset(14)
        }
        
        contentView.addSubview(footerDividerView)
        footerDividerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(postImageView.snp.bottom).offset(14)
        }
        
        let likeContainerStack = UIStackView(arrangedSubviews: [likeButton,
                                                                likesCountLabel,])
        likeContainerStack.axis = .horizontal
        likeContainerStack.distribution = .fillEqually
        
        let shareContainerStack = UIStackView(arrangedSubviews: [shareButton,
                                                                 sharesCountLabel,])
        shareContainerStack.axis = .horizontal
        shareContainerStack.distribution = .fillEqually
        
        let postViewContainerStack = UIStackView(arrangedSubviews: [postViewsImageView,
                                                                    postViewsCountLabel,])
        postViewContainerStack.axis = .horizontal
        postViewContainerStack.distribution = .fillEqually
        
        let commentContainerStack = UIStackView(arrangedSubviews: [commentButton,
                                                                   commentsCountLabel])
        commentContainerStack.axis = .horizontal
        commentContainerStack.distribution = .fillEqually
    
        let stack = UIStackView(arrangedSubviews: [likeContainerStack,
                                                   shareContainerStack,
                                                   postViewContainerStack,
                                                   commentContainerStack])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fillEqually
        
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(footerDividerView.snp.bottom).offset(8)
            make.left.equalTo(footerDividerView.snp.left).offset(12)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
