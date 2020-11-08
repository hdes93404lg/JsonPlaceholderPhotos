//
//  DetailViewController.swift
//  JsonPlaceholderPhotos
//
//  Created by 陳韋中 on 2020/11/7.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlet Properties

    @IBOutlet weak var photoImageView: CustomImageView! {
        didSet {
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var idLabel: UILabel! {
        didSet {
            idLabel.text = nil
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = nil
            titleLabel.numberOfLines = 0
        }
    }
    
    // MARK: - Properties

    var photo: Photo?

    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupPhoto()
    }
}

// MARK: - Setup Methods

extension DetailViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("Detail", comment: "")
    }
    
    private func setupPhoto() {
        guard let photo = self.photo else { return }
        photoImageView.loadImage(with: photo.url)
        idLabel.text = "id: \(photo.id)"
        titleLabel.text = "title: \(photo.title)"
    }
}
