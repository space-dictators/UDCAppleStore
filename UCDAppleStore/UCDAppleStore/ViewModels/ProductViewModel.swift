//
//  ProductViewModel.swift
//  UCDAppleStore
//
//  Created by 이서린 on 6/26/25.
//

import Foundation

class ProductViewModel {
    private var allProducts: [Product] = []
    private(set) var products: [Product] = []

    var onDataUpdated: (() -> Void)?

    func fetchProducts() {
        let loadedProducts = DataService.shared.loadProducts()
        allProducts = loadedProducts
        products = loadedProducts
        onDataUpdated?()
    }

    func filterProducts(by category: Category) {
        products = allProducts.filter { $0.category == category }
        onDataUpdated?()
    }

    func numberOfItems() -> Int {
        return products.count
    }

    func product(at index: Int) -> Product? {
        guard index >= 0, index < products.count else { return nil }
        return products[index]
    }
}
