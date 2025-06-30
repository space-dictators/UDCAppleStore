
import Foundation

final class CartViewModel {
    // MARK: Properties

    private(set) var cartItems: [CartItem]

    // MARK: Closuers

    var onAlertTriggered: ((CartAlertType) -> Void)?

    // MARK: Initailizers

    init() {
        // 테스트용 하드코딩 데이터
        cartItems = [
            CartItem(
                product: Product(
                    id: 1,
                    name: "iPhone 16",
                    category: .iphone,
                    price: 1_250_000,
                    imageURL: URL(string: "https://store.storeimages.cdn-apple.com/...")!
                ),
                quantity: 1
            ),
            CartItem(
                product: Product(
                    id: 2,
                    name: "iPhone 16 Plus",
                    category: .iphone,
                    price: 1_350_000,
                    imageURL: URL(string: "https://store.storeimages.cdn-apple.com/...")!
                ),
                quantity: 2
            ),
            CartItem(
                product: Product(
                    id: 6,
                    name: "iPad A16",
                    category: .ipad,
                    price: 529_000,
                    imageURL: URL(string: "https://store.storeimages.cdn-apple.com/...")!
                ),
                quantity: 2
            ),
            CartItem(
                product: Product(
                    id: 12,
                    name: "MacBook Air M4 13〃 16GB 256GB",
                    category: .ipad,
                    price: 1_590_000,
                    imageURL: URL(string: "https://store.storeimages.cdn-apple.com/...")!
                ),
                quantity: 1
            ),
        ]
    }

    // MARK: Properties

    var totalPriceText: String {
        "총액 : \(cartItems.reduce(0) { $0 + $1.totalPrice }.formattedWithComma)원"
    }

    var purchaseButtonTitle: String {
        "총 \(cartItems.reduce(0) { $0 + $1.quantity })개 결제하기"
    }

    var isPurchaseAvailable: Bool {
        cartItems.reduce(0) { $0 + $1.quantity } > 0
    }

    // MARK: Methods

    // 장바구니에 상품 추가
    func addCartItem(_ item: CartItem) {
        // 이미 있는 상품이면
        if let index = cartItems.firstIndex(where: { $0.product.id == item.product.id }) {
            var item = cartItems[index]

            if item.quantity < 10 {
                item.quantity += 1
                cartItems[index] = item
            } else {
                // 10개 초과시 예외처리
                onAlertTriggered?(.quantityLimitExceeded)
                return
            }
        } else {
            // 새 상품이라면
            let newItem = CartItem(product: item.product, quantity: 1)
            cartItems.append(newItem)
        }
    }

    // 수량 증가
    func increaseQuantiy(for product: Product) {
        // product id를 이용해 어떤 상품의 인덱스인지 찾아서 할당
        guard let index = cartItems.firstIndex(where: { $0.product.id == product.id }) else {
            return // 비어있을 경우 아무것도 하지 않음
        }

        var item = cartItems[index]

        if item.quantity >= 10 { // 이미 10개 이상이라면
            // 최대 수량(10개) 초과
            onAlertTriggered?(.quantityLimitExceeded)
            return
        }
        item.quantity += 1

        cartItems[index] = item // 바뀐 값 재할당
    }

    // 수량 감소
    func decreaseQuantiy(for product: Product) {
        guard let index = cartItems.firstIndex(where: { $0.product.id == product.id }) else {
            return // 비어있을 경우 아무것도 하지 않음
        }

        var item = cartItems[index]

        if item.quantity == 1 {
            onAlertTriggered?(.confirmRemoveItem(item.product))
            return
        }

        item.quantity -= 1
        cartItems[index] = item // 바뀐 값 재할당
    }

    func removeItem(for product: Product) {
        cartItems.removeAll { $0.product.id == product.id }
    }

    // 카트 비우기
    func clearCart() {
        cartItems.removeAll()
    }
}

// Alert종류를 나타내는 enum
enum CartAlertType {
    case quantityLimitExceeded // 10개에서 +버튼을 눌렀을 때
    case confirmRemoveItem(Product) // 수량 1개에서 -버튼 눌렀을 때 삭제 여부
    case confirmClearCart // 초기화 버튼을 눌렀을 때
}
