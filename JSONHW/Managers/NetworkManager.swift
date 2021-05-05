//
//  NetworkManager.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 04.05.2021.
//

import Alamofire

class NetworkManager {
    //test
    static let shared = NetworkManager()
    private init() {}
    
    //MARK: - URLSession methods
    func fetchAPOD(from url: String?, with completion: @escaping (NasaPOD) -> Void) {
        guard let stringURL = url else { return }
        guard let contentURL = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: contentURL) { data, _, error in
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            do {
                let apod = try JSONDecoder().decode(NasaPOD.self, from: data)
                
                DispatchQueue.main.async {
                    completion(apod)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    // URLSession
    func fetchJokes(from url: String?, with completion: @escaping ([Joke]) -> Void) {
        guard let stringURL = url else { return }
        guard let contentURL = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: contentURL) { data, response, error in
            guard let data = data else {
                print("error 1")
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            do {
                let jokes = try JSONDecoder().decode([Joke].self, from: data)
                print("super 2")
                completion(jokes)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    //MARK: - Alamofire methods
    
    func alamofireFetchAPOD(from url: String?, with completion: @escaping (Result<NasaPOD, Error>) -> Void) {
        guard let stringUrl = url else { return }
        
        AF.request(stringUrl)
            .validate()
            .responseJSON { dataResponse in
                
                switch dataResponse.result {
                
                case .success( let json):
                    guard let jsonData = json as? [String: Any] else { return }
                    
                    // экземпляр модели в модельном слое
                    let nasaPOD = NasaPOD.init(jsonData: jsonData)
                    
                    DispatchQueue.main.async {
                        completion(.success(nasaPOD))
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func alamofireFetchJokes(from url: String?, with completion: @escaping (Result<[Joke], Error>) -> Void) {
        var jokes: [Joke] = []
        guard let stringUrl = url else { return }
            
        AF.request(stringUrl)
            .validate()
            .responseJSON { dataResponse in
                
                switch dataResponse.result {
                
                case .success( let json):
                    jokes = Joke.getJokes(from: json)
                    
                    DispatchQueue.main.async {
                        completion(.success(jokes))
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func alamofireFetchImage(from url: String?, with completion: @escaping (Result<Data, Error>) -> Void) {
        guard let stringUrl = url else { return }
        
        AF.request(stringUrl)
            .validate()
            .responseData { dataResponse in
                
                switch dataResponse.result {
                
                case .success(let dataServer):
                    
                    DispatchQueue.main.async {
                        completion(.success(dataServer))
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
