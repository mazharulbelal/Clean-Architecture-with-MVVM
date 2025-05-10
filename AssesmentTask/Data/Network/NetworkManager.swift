//
//  NetworkManager.swift
//  AssesmentTask
//
//  Created by Mazharul on 10/5/25.
//

import Combine
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // URLSession with Combine
    func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[Product], Error> {
        let urlString = "https://dummyjson.com/products?limit=\(limit)&skip=\(page * limit)&sortBy=price%2Ctitle&order=asc"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ProductResponse.self, decoder: JSONDecoder())
            .map { $0.products }
            .eraseToAnyPublisher()
    }
}
