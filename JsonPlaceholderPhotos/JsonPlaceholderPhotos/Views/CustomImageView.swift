//
//  CustomImageView.swift
//  JsonPlaceholderPhotos
//
//  Created by 陳韋中 on 2020/11/7.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    // MARK: - Properties
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
    }()
    
    var lastImgUrlUsedToLoadImage: String?
}

// MARK: - Setup Methods

extension CustomImageView {
    
    private func setupActivityIndicatorView() {
        activityIndicatorView.style = .medium
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}

// MARK: - API Methods

extension CustomImageView {
    
    func loadImage(with urlString: String) {
        
        lastImgUrlUsedToLoadImage = urlString

        guard let url = URL(string: urlString) else { return }

        image = nil
    
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        setupActivityIndicatorView()
        activityIndicatorView.startAnimating()
                
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
            }
            
            if let error = error {
                #if DEBUG
                print("Load image error: \(error.localizedDescription)")
                #endif
                return
            }
            
            guard self?.lastImgUrlUsedToLoadImage == url.absoluteString else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: urlString as NSString)
                self?.image = image
            }
        
        }.resume()
    }
}
