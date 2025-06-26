//
//  ProductViewModel.swift
//  UCDAppleStore
//
//  Created by 이서린 on 6/26/25.
//

import Foundation

class ProductViewModel {
    private(set) var products: [Product] = []

    var onDataUpdated: (() -> Void)?

    func fetchProducts() {
        products = DataService.shared.loadProducts()
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
