//
//  NetworkManager.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit

struct NetworkManager {
    
    static let shared       = NetworkManager()
    private let baseURL     = "https://newsapi.org/v2/"
    let cache               = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getArticles(for keyword: String, date: String, page: Int, completed: @escaping (Result<[Article], PSError>) -> Void) {
        
        let endpoint = baseURL + "everything?q=\(keyword)&from=\(date)&sortBy=popularity&pageSize=20&page=\(page)&apiKey=bc0556bf8d8a43d7806e669f113965c6"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidSearchQuery))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let request = try decoder.decode(Request.self, from: data)
                completed(.success(request.articles))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        
        task.resume()
    }
}

