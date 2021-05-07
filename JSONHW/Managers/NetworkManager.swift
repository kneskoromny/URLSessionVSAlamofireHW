//
//  NetworkManager.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 04.05.2021.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    //MARK: - URLSession methods
    // escaping замыкание позволяет захватывать объекты с собой и переносить их за пределы класса, в котором работает
    func fetchAPOD(from url: String?, with completion: @escaping (NasaPOD) -> Void) {
        // получаем экземпляр класса URL по инициализатору с String, тк возвращается опционал - делаем через guard
        guard let stringURL = url else { return }
        guard let contentURL = URL(string: stringURL) else { return }
        
        // URLSession - класс, отвечающий за создание сессии, в completion содержится ответ от сервера: data - данные, response - ответ сервера, error - ошибка. Запрос происходит в фоновом потоке.
        URLSession.shared.dataTask(with: contentURL) { data, _, error in
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            do {
                // расшифровываем json, на выходе хотим получить тип данных по модели NasaPOD из данных data
                let apod = try JSONDecoder().decode(NasaPOD.self, from: data)
                
                // переходим в основной поток для передачи результата в completion
                DispatchQueue.main.async {
                    // здесь происходит захват экземпляра с типом данных модели NasaPod для дальнейшей передачи вне класса
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
    // нужный тип данных NasaPod указывается через enum Result case success, в case failure указывается ошибка
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
                        // в случае успеха передаем в completion case success c типом данных NasaPod
                        completion(.success(nasaPOD))
                    }
                // в случае ошибки создаем экземпляр модели с типом Error и отправляем его в блок completion, чтобы далее можно было указать ошибку для пользователя, например в AlertController
                case .failure(let error):
                    completion(.failure(error))
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
                    completion(.failure(error))
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
                    completion(.failure(error))
                }
            }
    }
}
