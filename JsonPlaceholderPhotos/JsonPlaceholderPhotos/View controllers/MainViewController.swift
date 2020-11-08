//
//  MainViewController.swift
//  JsonPlaceholderPhotos
//
//  Created by 陳韋中 on 2020/11/1.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = NSLocalizedString("JSON Placeholder", comment: "")
        }
    }
    
    @IBOutlet weak var requestAPIButton: UIButton! {
        didSet {
            requestAPIButton.setTitle(NSLocalizedString("Request API", comment: ""), for: .normal)
            requestAPIButton.addTarget(self, action: #selector(requestAPITapped), for: .touchUpInside)
        }
    }
    
    // MARK: - Properties
    
    private lazy var downloadManager: DownloadManager = {
        return DownloadManager()
    }()
    
    private let photosSegueId = "PhotosSegueId"
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    // MARK: - UIStoryboardSegue
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == photosSegueId {
            guard let photosVC = segue.destination as? PhotosCollectionViewController,
                  let photos = sender as? [Photo] else { return }
            photosVC.photos = photos
        }
    }
}

// MARK: - Setup Methods

extension MainViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("Main", comment: "")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - Action Methods

extension MainViewController {

    @objc func requestAPITapped() {
        
        fetchPhotos()
    }
}

// MARK: - API Methods

extension MainViewController {
    
    private func fetchPhotos() {
        
        downloadManager.fetchPhotos { (photos, error) in
            
            if let error = error {
                #if DEBUG
                print("FetchPhotos error: \(error.localizedDescription)")
                #endif
                return
            }
            
            guard let photos = photos,
                  !photos.isEmpty else {
                #if DEBUG
                print("FetchPhotos error: photos is empty.")
                #endif
                return
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: self.photosSegueId, sender: photos)
            }
        }
    }
}
