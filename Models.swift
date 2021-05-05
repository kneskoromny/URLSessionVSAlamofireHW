//
//  NASAPicture.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//


struct NasaPOD: Decodable {
    
    let copyright: String?
    let date: String?
    let title: String?
    let url: String?
    
    var description: String {
        """
        Перед Вами NASA AstroPhotoOfTheDay \(date ?? "")!
        Оно называется
        "\(title ?? "")".
        Это фото было загружено \(copyright ?? "неизвестным").
        """
    }
    
    init(jsonData: [String: Any]) {
        copyright = jsonData["copyright"] as? String
        date = jsonData["date"] as? String
        title = jsonData["title"] as? String
        url = jsonData["url"] as? String
    }
}

struct Joke: Decodable {
    
    let setup: String?
    let punchline: String?
    
    init(jsonData: [String: Any]) {
        setup = jsonData["setup"] as? String
        punchline = jsonData["punchline"] as? String
    }
    
    static func getJokes(from json: Any) -> [Joke] {
        guard let jsonDates = json as? [[String: Any]] else { return []}
        
        return jsonDates.compactMap { Joke(jsonData: $0)}
        
    }
}
