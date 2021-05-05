//
//  APIManager.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 04.05.2021.
//

struct APIManager {
    static let shared = APIManager()
    private init() {}
    
    // test
    let joke = "https://official-joke-api.appspot.com/jokes/ten"
    let nasaAPOD = "https://api.nasa.gov/planetary/apod?api_key=lKtTVBLWcJwffu52fyYVGG2E8tjyEsp04LWMtLtx"
    let happyObama = "https://i.postimg.cc/9XD970g1/image.jpg"
}
