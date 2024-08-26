//
//  NetworkManager.swift
//  FakeStoreApi
//
//  Created by Андрей Бабкин on 20.08.2024.
//

import SwiftUI
import Alamofire

class NetworkManager: ObservableObject {
    func getAllProducts(complition: @escaping(Result<[Products], Error>) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            return
        }
        AF.request(url, method: .get).response { response in
            if let error = response.error {
                complition(.failure(error))
            } else {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    guard let responseData = try? decoder.decode([Products].self, from: data) else { return }
                    complition(.success(responseData))
                }
            }
        }
    }
}

