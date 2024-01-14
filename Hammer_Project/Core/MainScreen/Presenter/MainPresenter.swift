//
//  MainPresenter.swift
//  Hammer_Project
//
//  Created by Alikhan Tursunbekov on 13/1/24.
//

import Foundation

enum Operation {
    case pizza
    case combo
    case desert
    case drinks
    
    func getURL() -> String {
            switch self {
            case .pizza:
                return "https://run.mocky.io/v3/ccbab315-5d4e-4966-8e0d-515ff96c5694"
            case .combo:
                return "https://run.mocky.io/v3/4ddfc7b4-3f49-4b87-ac3c-4f8f9fe90b9b"
            case .desert:
                return "https://run.mocky.io/v3/bd981ae4-bdf8-48b0-b657-8421efea17b9"
            case .drinks:
                return "https://run.mocky.io/v3/4562905a-016c-4eae-bc36-f876f3c762b3"
            }
        }
}

protocol PresenterDelegate {
    func responceAction()
}

class MainPresenter {
    var pizza: [PizzaItem] = []
    let images = ["banner", "banner2"]
    let categories = ["Пицца", "Комбо", "Десерты", "Напитки"]
    var selectedCategory = IndexPath(row: 0, section: 0)
    var delegate: PresenterDelegate?
    
    func fetchData(url: Operation) {
        let header = ["Content-Type" : "application/json"]
        
        NetworkManager.request(urlString: url.getURL(), method: .get ,headers: header) { (result: Result<[PizzaItem], NetworkError>)  in
                switch result {
                case .success(let res):
                    self.pizza = res
                    self.delegate?.responceAction()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}
