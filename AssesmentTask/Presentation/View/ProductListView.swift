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
                        .padding(.bottom, 10)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
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


#Preview {
    ProductListView()
}

