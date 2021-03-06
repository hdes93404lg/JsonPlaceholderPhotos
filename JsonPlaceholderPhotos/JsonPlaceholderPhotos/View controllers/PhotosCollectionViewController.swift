//
//  PhotosCollectionViewController.swift
//  JsonPlaceholderPhotos
//
//  Created by 陳韋中 on 2020/11/7.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    private let photoCellId = "PhotoCellId"
    private let detailSegueId = "DetailSegueId"
    
    var photos: [Photo] = []
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }

    // MARK: - UIStoryboardSegue
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == detailSegueId {
            guard let detailVC = segue.destination as? DetailViewController,
                  let photo = sender as? Photo else { return }
            detailVC.photo = photo
        }
    }
}

// MARK: - Setup Methods

extension PhotosCollectionViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("Photos", comment: "")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellId, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }

        let photo = photos[indexPath.item]
        cell.thumbnailImageView.loadImage(with: photo.thumbnailURL)
        cell.idLabel.text = String(photo.id)
        cell.titleLabel.text = photo.title
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension PhotosCollectionViewController {
 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        performSegue(withIdentifier: detailSegueId, sender: photo)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
