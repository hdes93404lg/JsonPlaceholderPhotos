//
//  PhotoCollectionViewCell.swift
//  JsonPlaceholderPhotos
//
//  Created by 陳韋中 on 2020/11/7.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var thumbnailImageView: CustomImageView! {
        didSet {
            thumbnailImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var idLabel: UILabel! {
        didSet {
            idLabel.text = nil
            idLabel.textAlignment = .center
            idLabel.font = .boldSystemFont(ofSize: 17)
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
    
    // MARK: - Cell Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
         
        thumbnailImageView.image = nil
        idLabel.text = nil
        titleLabel.text = nil
    }
}
