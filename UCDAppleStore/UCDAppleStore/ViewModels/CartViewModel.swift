
import Foundation

final class CartViewModel {
    // MARK: Properties

    private(set) var cartItems: [CartItem] = []

    // MARK: Closuers

    var onCartUpdated: (() -> Void)?
    var onAlertTriggered: ((CartAlertType) -> Void)?

    // MARK: Properties

    var totalPriceText: String {
        .localized("총액 : \(cartItems.reduce(0) { $0 + $1.totalPrice }.formattedWithComma)원")
    }

    var purchaseButtonTitle: String {
        .localized("총 \(cartItems.reduce(0) { $0 + $1.quantity })개 결제하기")
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
                print("🚨 수량 초과 알러트")
                onAlertTriggered?(.quantityLimitExceeded)
                return
            }
        } else {
            // 새 상품이라면
            let newItem = CartItem(product: item.product, quantity: 1)
            cartItems.append(newItem)
        }

        onCartUpdated?()
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
            print("🚨 수량 초과 알러트")
            onAlertTriggered?(.quantityLimitExceeded)
            return
        }
        item.quantity += 1

        cartItems[index] = item // 바뀐 값 재할당
        onCartUpdated?()
    }

    // 수량 감소
    func decreaseQuantiy(for product: Product) {
        guard let index = cartItems.firstIndex(where: { $0.product.id == product.id }) else {
            return // 비어있을 경우 아무것도 하지 않음
        }

        var item = cartItems[index]

        if item.quantity == 1 {
            print("🚨 삭제 알러트")
            onAlertTriggered?(.confirmRemoveItem(item.product))
            return
        }

        item.quantity -= 1
        cartItems[index] = item // 바뀐 값 재할당
        onCartUpdated?()
    }

    func removeItem(for product: Product) {
        cartItems.removeAll { $0.product.id == product.id }
        onCartUpdated?()
    }

    // 카트 비우기
    func clearCart() {
        cartItems.removeAll()
        onCartUpdated?()
    }
}
