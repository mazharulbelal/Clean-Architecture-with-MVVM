//
//  ProductListView.swift
//  AssesmentTask
//
//  Created by Mazharul on 10/5/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.products) { product in
                    ProductCardView(product: product)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                if let error = viewModel.error {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .onAppear {
                viewModel.loadNextPage()
            }
            .refreshable {
                viewModel.refreshData()
            }
            .navigationTitle("Products")
        }
    }
}
