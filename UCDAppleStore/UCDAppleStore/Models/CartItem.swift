

import Foundation

struct CartItem: Hashable {
    let product: Product
    var quantity: Int
    
    var totalPrice: Int {
        return product.price * quantity
    }
}
