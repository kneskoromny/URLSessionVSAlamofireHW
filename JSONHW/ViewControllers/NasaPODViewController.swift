//
//  ViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//

import UIKit
import Alamofire

class NasaPODViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        descriptionLabel.text = """
            Пожалуйста, подождите пару секунд.
            Я загружаю кое-что интересное для Вас:)
            """
        
        alamofireFetchData(from: APIManager.shared.nasaAPOD)
        
    }
    //MARK: - Private methods
    private func alamofireFetchData(from url: String?) {
        // здесь возвращается тип данных модели Nasapod из escaping замыкания в виде result
        NetworkManager.shared.alamofireFetchAPOD(from: url) { result in
            switch result {
            // success уже содержит внутри себя тип данных NasaPod, нужно присвоить его свойству apod
            case .success(let apod):
                // настраиваем вью из данных экземпляра модели
                self.configureView(from: apod)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureView(from object: NasaPOD) {
        descriptionLabel.text = object.description
        
        guard let imageURL = URL(string: object.url ?? "") else { return }
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        
        imageView.image = UIImage(data: imageData)
        activityIndicator.stopAnimating()
    }
}
