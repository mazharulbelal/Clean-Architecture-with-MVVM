//
//  ProductModel.swift
//  AssesmentTask
//
//  Created by Mazharul on 10/5/25.
//

import Foundation


struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let price: Double
    let discountedPrice: Double
    let rating: Double
    let imageUrl: String
    let category: String
    let stock: Int

    enum CodingKeys: String, CodingKey {
        case id, title, price, discountedPrice, rating
        case imageUrl = "thumbnail"
        case category, stock
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Untitled"
        self.price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
        self.discountedPrice = try container.decodeIfPresent(Double.self, forKey: .discountedPrice) ?? self.price
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? "Unknown"
        self.stock = try container.decodeIfPresent(Int.self, forKey: .stock) ?? 0
    }
}


struct ProductResponse: Decodable {
    let products: [Product]
}
