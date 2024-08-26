//
//  ContentView.swift
//  FakeStoreApi
//
//  Created by Андрей Бабкин on 19.08.2024.
//

import SwiftUI
import Kingfisher

struct MainScreen: View {
    @StateObject var viewModel = MainScreenViewModel()
    var columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 2)
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.product, id: \.id) { products in
                        NavigationLink(value: products) {
                            ProductsItem(products: products)
                        }
                    }
                    
                }
                .padding(.horizontal)
                .onAppear {
                    viewModel.getProducts()
                }
            }
            .navigationTitle("Some shop")
            .navigationDestination(for: Products.self) { products in
                VStack() {
                    Text(products.title)
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .bold()
                    KFImage(URL(string: products.image))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.3)
                        .padding()
                    HStack(spacing: 3) {
                        Text(String(format: "%.02f", products.price))
                            .foregroundStyle(.black)
                            .bold()
                            .font(.system(size: 20))
                        Text("$")
                            .foregroundStyle(.black)
                    }
                    HStack(spacing: 3) {
                        Image("RaitingStar")
                        Text(String(format: "%.01f", products.rating.rate))
                            .foregroundStyle(.black)
                            .font(.system(size: 18))
                            .padding(.trailing)
                        Text("\(products.rating.count) pcs.")
                            .foregroundStyle(.black)
                            .font(.system(size: 18))
                    }
                    Text(products.description)
                        .font(.system(size: 18))
                        .minimumScaleFactor(0.5)
                        .padding(.bottom)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ProductsItem: View {
    var products: Products
    @State private var likeToggle: Bool = false
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .topTrailing) {
                VStack {
                    KFImage(URL(string: products.image))
                        .resizable()
                        .frame(width: 120, height: 120)
                    HStack(spacing: 3) {
                        Image("RaitingStar")
                        Text(String(format: "%.01f", products.rating.rate))
                            .foregroundStyle(.black)
                            .font(.system(size: 12))
                        Spacer()
                        Text("\(products.rating.count) pcs.")
                            .foregroundStyle(.black)
                            .font(.system(size: 12))
                    }
                    .padding(.horizontal)
                    Text(products.category)
                        .foregroundStyle(.black)
                        .font(.system(size: 12))
                        .padding(.bottom)
                    Text(products.title)
                        .foregroundStyle(.black)
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    HStack(spacing: 3) {
                        Text(String(format: "%.02f", products.price))
                            .foregroundStyle(.black)
                            .bold()
                            .font(.system(size: 16))
                        Text("$")
                            .foregroundStyle(.black)
                    }
                }
                .padding(.top)
                .padding(.bottom)
                .frame(width: reader.size.width, height: reader.size.height)
                
                Button(action: {
                    likeToggle.toggle()
                }) {
                    if likeToggle == false {
                        Image(systemName: "heart")
                            .foregroundStyle(Color.black)
                    } else {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(Color.red)
                    }
                }
                .frame(width: 35, height: 35)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.44, height: 278)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 16))
        .shadow(radius: 4)
    }
}

#Preview {
    MainScreen()
}
