//
//  ImageManager.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 09.05.2021.
//

import Foundation

class ImageManager {

    static let shared = ImageManager()
    private init() {}

    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data, let response = responce else {
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            guard url == responce?.url else { return }
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}




