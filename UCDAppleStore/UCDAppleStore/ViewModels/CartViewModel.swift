
import Foundation

final class CartViewModel {
    private(set) var testCart: Cart

    init() {
        // 하드코딩된 테스트 데이터
        let testCartItems: [CartItem] = [
            CartItem(
                product: Product(
                    id: 1,
                    name: "iPhone 16",
                    category: .iPhone,
                    price: 1_250_000,
                    imageURL: URL(string: "https://store.storeimages.cdn-apple.com/...")!
                ),
                quantity: 1
            ),
            CartItem(
                product: Product(
                    id: 2,
                    name: "iPhone 16 Plus",
                    category: .iPhone,
                    price: 1_350_000,
                    imageURL: URL(string: "https://store.storeimages.cdn-apple.com/...")!
                ),
                quantity: 2
            ),
            CartItem(
                product: Product(
                    id: 6,
                    name: "iPad A16",
                    category: .iPad,
                    price: 529_000,
                    imageURL: URL(string: "https://store.storeimages.cdn-apple.com/...")!
                ),
                quantity: 1
            ),
        ]

        testCart = Cart(items: testCartItems)
    }

    var totalPriceText: String {
        "\(testCart.totalPrice)원"
    }

    var purchaseButtonTitle: String {
        "총 \(testCart.totalCount)개 결제하기"
    }
}
