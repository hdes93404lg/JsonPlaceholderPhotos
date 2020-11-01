//
//  MainViewController.swift
//  JsonPlaceholderPhotos
//
//  Created by 陳韋中 on 2020/11/1.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var requestApiButton: UIButton!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupRequestApiButton()
    }
}

// MARK: - Setup Methods

extension MainViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("JSON Placeholder", comment: "")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    private func setupRequestApiButton() {
        requestApiButton.setTitle(NSLocalizedString("Request API", comment: ""), for: .normal)
        requestApiButton.addTarget(self, action: #selector(onClickRequestApiButton), for: .touchUpInside)
    }
}

// MARK: - Action Methods

extension MainViewController {

    @objc private func onClickRequestApiButton() {
        
        handleRequestAPI()
    }
}

// MARK: - API Methods

extension MainViewController {
    
    private func handleRequestAPI() {
        
    }
}
