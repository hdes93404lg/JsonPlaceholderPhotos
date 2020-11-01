//
//  DownloadManager.swift
//  JsonPlaceholderPhotos
//
//  Created by 陳韋中 on 2020/11/1.
//

import Foundation

class DownloadManager {
    
    // MARK: - Properties
    
    struct BaseAPI {
        static let url = "https://jsonplaceholder.typicode.com"
    }
    
    struct EndPoit {
        static let photos = "/photos"
    }
    
    // MARK: - Enumerations

    enum HttpMethod: String {
        case get
    }
}

// MARK: - API Methods

extension DownloadManager {
    
    func fetchPhotos(completion: @escaping ([Photo]?, Error?) -> Void) {
        
        guard let url = URL(string: BaseAPI.url + EndPoit.photos) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get.rawValue
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
        
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(photos, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
