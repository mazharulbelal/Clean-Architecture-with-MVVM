//
//  ProductCardView.swift
//  AssesmentTask
//
//  Created by Mazharul on 10/5/25.
//


import SwiftUI
import Kingfisher

struct ProductCardView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                KFImage(URL(string: product.imageUrl))
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
            
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipped()

                Text(product.category)
                    .font(.caption2)
                    .padding(5)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(6)
            }

            Text(product.title)
                .font(.headline)
                .lineLimit(2)

            HStack {
                Text("$\(product.price, specifier: "%.2f")")
                    .strikethrough(product.discountedPrice < product.price, color: .red)

                if product.discountedPrice < product.price {
                    Text("$\(product.discountedPrice, specifier: "%.2f")")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }

            Text("\(product.rating, specifier: "%.1f") ★")
                .font(.subheadline)
                .foregroundColor(.orange)

            if product.stock <= 5 {
                Text("Only \(product.stock) left!")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
