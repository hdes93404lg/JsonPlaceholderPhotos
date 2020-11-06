//
//  MainViewController.swift
//  JsonPlaceholderPhotos
//
//  Created by 陳韋中 on 2020/11/1.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var requestAPIButton: UIButton!
    
    // MARK: - Properties
    
    private lazy var downloadManager: DownloadManager = {
        return DownloadManager()
    }()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupRequestAPIButton()
    }
}

// MARK: - Setup Methods

extension MainViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("JSON Placeholder", comment: "")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupRequestAPIButton() {
        requestAPIButton.setTitle(NSLocalizedString("Request API", comment: ""), for: .normal)
        requestAPIButton.addTarget(self, action: #selector(requestAPITapped), for: .touchUpInside)
    }
}

// MARK: - Action Methods

extension MainViewController {

    @objc func requestAPITapped() {
        
        fetchPhotos()
    }
}

// MARK: - Private Methods

extension MainViewController {
    
    private func fetchPhotos() {
        
        downloadManager.fetchPhotos { (photos, error) in
            
            if let error = error {
                #if DEBUG
                print("FetchPhotos error: \(error.localizedDescription)")
                #endif
                return
            }
            
            if let photos = photos {
                #if DEBUG
                print("FetchPhotos success: \(photos.count)")
                #endif
            }
        }
    }
}
