//
//  Model.swift
//  FakeStoreApi
//
//  Created by Андрей Бабкин on 20.08.2024.
//

import SwiftUI

struct Products: Hashable, Codable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: String
    var rating: Rating
}

struct Rating: Hashable, Codable {
    var rate: Double
    var count: Int
}
