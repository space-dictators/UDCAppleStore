
import Foundation

final class CartViewModel {
    // 테스트용 하드 코딩 데이터
    private(set) var testCart: [CartItem] = [
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
}
