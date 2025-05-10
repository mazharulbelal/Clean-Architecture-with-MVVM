//
//  ProductViewModel.swift
//  AssesmentTask
//
//  Created by Mazharul on 10/5/25.
//

import Foundation
import Combine

class ProductListViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var currentPage = 0
    private let limit = 10
    private var cancellables: Set<AnyCancellable> = []
    
    // Fetch next page of products
    func loadNextPage() {
        guard !isLoading else { return }
        isLoading = true
        
        NetworkManager.shared.fetchData(route: .products, responseType: ProductResponse.self)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.isLoading = false
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.products.append(contentsOf: response.products)
                self?.currentPage += 1
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    // Pull to refresh
    func refreshData() {
        currentPage = 0
        products.removeAll()
        loadNextPage()
    }
}
