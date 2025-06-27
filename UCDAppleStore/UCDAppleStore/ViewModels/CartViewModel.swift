
import Foundation

final class CartViewModel {
    
    // MARK: Properties
    
    private(set) var cartItems: [CartItem]

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
        "\(cartItems.reduce(0) { $0 + $1.totalPrice })원"
    }

    var purchaseButtonTitle: String {
        "총 \(cartItems.reduce(0) { $0 + $1.quantity })개 결제하기"
    }

    // MARK: Methods
    
    // 수량 증가
    func changeQuantity(for product: Product, isIncrease: Bool) {
        // product id를 이용해 어떤 상품의 인덱스인지 찾아서 할당
        guard let index = cartItems.firstIndex(where: { $0.product.id == product.id }) else {
            return // 비어있을 경우 아무것도 하지 않음
        }

        var item = cartItems[index]

        if isIncrease { // true, +버튼을 눌렀을 때
            if item.quantity >= 10 { // 이미 10개 이상이라면
                // TODO: Alert - 최대 수량(10개) 초과
                return
            }
            item.quantity += 1
        } else { // false, - 버튼을 눌렀을 때
            if item.quantity == 0 { // 이미 0개일 경우
                // TODO: Alert - 최소 수량(0개) 미만
                return
            }
            item.quantity -= 1
        }

        cartItems[index] = item // 바뀐 값 재할당
    }
    
    // 카트 비우기
    func clearCart() {
        // TODO: Alert - 확인 메시지 출력
        cartItems.removeAll()
    }
}
