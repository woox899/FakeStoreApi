//
//  ItemViewModel.swift
//  FakeStoreApi
//
//  Created by Андрей Бабкин on 20.08.2024.
//

import SwiftUI

class MainScreenViewModel: ObservableObject {
    @Published var product = [Products]()
    
    var networkManager = NetworkManager()
    
    func getProducts() {
        networkManager.getAllProducts() { [weak self] products in
            switch products {
            case .success(let model):
                self?.product = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


