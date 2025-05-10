//
//  ProductModel.swift
//  AssesmentTask
//
//  Created by Mazharul on 10/5/25.
//

import Foundation

// A simple Product model
struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let price: Double
    let discountedPrice: Double?
    let rating: Double
    let imageUrl: String
    let category: String
    let stock: Int
}

// API Response model
struct ProductResponse: Decodable {
    let products: [Product]
}
