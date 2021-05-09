//
//  CacheImageView.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 09.05.2021.
//

import UIKit

class CacheImageView: UIImageView {
    
    func fetchImage(from url: String) {
        
        guard let imageUrl = URL(string: url) else {
            image = UIImage(imageLiteralResourceName: "book")
            return
        }
        
        // случай: картинка к кэше есть
        if let cachedImage = getCachedImage(from: imageUrl) {
            image = cachedImage
        }
        
        // случай: картинки в кэше нет
        ImageManager.shared.fetchImage(from: imageUrl) { data, response in
            self.image = UIImage(data: data)
            
            self.saveDataToCache(with: data, and: response)
        }
        
        
        
    }
    // сохраняет в кэш
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
        
    }
    // загружает из кэша
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}

