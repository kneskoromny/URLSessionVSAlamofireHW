//
//  HappyObamaViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 01.05.2021.
//

import UIKit
import Alamofire

class HappyObamaViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        alamofireFetchData(from: APIManager.shared.happyObama)
    }
    
    //MARK: - Private Methods
    private func alamofireFetchData(from url: String?) {
        NetworkManager.shared.alamofireFetchImage(from: url) { result in
            switch result {
            
            case .success(let data):
                DispatchQueue.main.async {
                    
                    self.imageView.image = UIImage(data: data)
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

