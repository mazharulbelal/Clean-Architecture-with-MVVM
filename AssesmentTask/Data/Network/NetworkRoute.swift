//
//  NetworkRoute.swift
//  AssesmentTask
//
//  Created by Mazharul on 10/5/25.
//

import Foundation

enum APIVersion {
    case v1
    case v2
}

enum NetworkRoute: String {
    case products = "/products"
    
    private var version: APIVersion {
        return .v1 
    }

    var baseURL: URL {
        switch version {
        case .v1:
            return URL(string: "https://dummyjson.com/v1")!
        case .v2:
            return URL(string: "https://dummyjson.com/v2")!
        }
    }
    
    var fullURL: URL {
        return baseURL.appendingPathComponent(self.rawValue)
    }
}
