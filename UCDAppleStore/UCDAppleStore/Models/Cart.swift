
import Foundation

struct Cart: Hashable {
    private(set) var items: [CartItem] = []

    var totalPrice: Int {
        return items.reduce(into: 0) { $0 + $1.totalPrice }
    }

    var totalCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}
