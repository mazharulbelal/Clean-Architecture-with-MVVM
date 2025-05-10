//
//  NetworkManager.swift
//  AssesmentTask
//
//  Created by Mazharul on 10/5/25.
//

import Combine
import Foundation

// MARK: - Network Error
enum NetworkError: Error {
    case badURL
    case badResponse(Int)
    case decoding(Error)
    case unknown(Error)
}

// MARK: - NetworkManager
import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // Perform a request based on the route
    func fetchData<T: Decodable>(route: NetworkRoute, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: route.rawValue, relativeTo: route.baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"  // Can add support for POST, PUT, DELETE here
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


