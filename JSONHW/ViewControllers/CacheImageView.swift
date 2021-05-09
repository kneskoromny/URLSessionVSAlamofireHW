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
        
        
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        
        
    }
}

