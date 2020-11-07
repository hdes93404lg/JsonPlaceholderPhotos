//
//  PhotoCollectionViewCell.swift
//  JsonPlaceholderPhotos
//
//  Created by 陳韋中 on 2020/11/7.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var thumbnailImageView: CustomImageView!
    
    @IBOutlet weak var idLabel: UILabel! {
        didSet {
            idLabel.text = nil
            idLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = nil
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 2
            titleLabel.lineBreakMode = .byWordWrapping
        }
    }
    
    // MARK: - Properties
    
    var photo: Photo? {
        didSet {
            guard let photo = self.photo else { return }
            thumbnailImageView.loadImage(with: photo.thumbnailURL)
            idLabel.text = String(photo.id)
            titleLabel.text = photo.title
        }
    }
    
    // MARK: - Cell Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
         
        thumbnailImageView.image = nil
        idLabel.text = nil
        titleLabel.text = nil
    }
}
