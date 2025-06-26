//
//  MainViewModel.swift
//  UCDAppleStore
//
//  Created by Milou on 6/25/25.
//

import Foundation

final class MainViewModel {
    private(set) var products: [Product] = []

    var onProductsUpdated: (() -> Void)?

    func fetchProducts() {
        guard let url = Bundle.main.url(forResource: "Product", withExtension: "json") else {
            print("JSON 파일 경로를 찾을 수 없습니다.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedProducts = try JSONDecoder().decode([Product].self, from: data)
            products = decodedProducts
            onProductsUpdated?()
        } catch {
            print("JSON 파싱 오류: \(error)")
        }
    }

    func product(at index: Int) -> Product {
        return products[index]
    }

    var numberOfProducts: Int {
        return products.count
    }
}
