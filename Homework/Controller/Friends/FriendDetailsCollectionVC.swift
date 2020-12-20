//
//  FriendCellDetailsCollectionVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendDetailsCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = collectionView.frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        self.collectionView?.setCollectionViewLayout(layout, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView!.register(FriendPhotosCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.isPagingEnabled = true
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends[0].photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotosCell
        cell.photoImageView.image = friends[0].photos[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let newCell = cell as? FriendPhotosCell {
            newCell.photoImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            UIView.animate(withDuration: 1.0, animations: {() -> Void in
                newCell.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
}
