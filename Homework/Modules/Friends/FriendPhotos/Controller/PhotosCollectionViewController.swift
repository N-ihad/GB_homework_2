//
//  FriendCellDetailsCollectionVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var userID: Int? {
        didSet {
            guard let userID = userID else { return }
            fetchPhotosOfUser(withID: userID)
        }
    }
    var photos: [Photo]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchPhotosOfUser(withID userID: Int) {
        BackendService.shared.getPhotosOfUser(withID: userID) { photos in
            self.photos = photos
        }
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = collectionView.frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(PhotosTableViewCell.self, forCellWithReuseIdentifier: PhotosTableViewCell.identifier)
        collectionView.isPagingEnabled = true
    }

}


// MARK: UICollectionViewDelegate / UICollectionViewDataSource

extension PhotosCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
        guard let photos = photos else { return cell }
        cell.photoImageView.kf.setImage(with: URL(string: photos[indexPath.row].photo604!))
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let newCell = cell as? PhotosTableViewCell {
            newCell.photoImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            UIView.animate(withDuration: 1.0, animations: {() -> Void in
                newCell.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom))
    }
}
