
import UIKit

import SnapKit

class ViewController: UIViewController, CartViewDelegate {
    private let cartView = CartView()

    private let addButton = UIButton().then {
        $0.setTitle("추가 테스트", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemGreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6

        // 카트뷰 테스트용
        view.addSubview(cartView)

        cartView.delegate = self

        cartView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        // 추가버튼 테스트용
//        view.addSubview(addButton)

//        addButton.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview().inset(24)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(80)
//            $0.height.equalTo(48)
//        }

        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    func cartCellDidIncreaseQuantity(for product: Product) {
        print("VC: + 버튼 눌림 - \(product.name)")
        cartView.cartViewModel.increaseQuantiy(for: product)
        cartView.reloadCartUI()
    }

    func cartCellDidDecreaseQuantity(for product: Product) {
        print("VC: - 버튼 눌림 - \(product.name)")
        cartView.cartViewModel.decreaseQuantiy(for: product)
        cartView.reloadCartUI()
    }

    func cartViewDidTapCancel() {
        print("VC: 초기화 버튼 눌림")
        cartView.cartViewModel.onAlertTriggered?(.confirmClearCart)
    }

    @objc private func addButtonTapped() {
        let product = Product(
            id: 11,
            name: "iPad Pro M5 13〃",
            category: .ipad,
            price: 2_099_000,
            imageURL: URL(string: "https://store.storeimages.cdn-apple.com/...")!
        )
        let item = CartItem(product: product, quantity: 1)
        cartView.cartViewModel.addCartItem(item)
        cartView.reloadCartUI()
    }

    func cartViewShouldShowAlert(_ alertType: CartAlertType) {
        var message = ""
        switch alertType {
        case .quantityLimitExceeded:
            message = "최대 수량은 10개입니다."

            let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)

        case let .confirmRemoveItem(product):
            let alert = UIAlertController(
                title: "알림",
                message: "\"\(product.name)\"을 삭제하시겠습니까?",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
                self?.cartView.cartViewModel.removeItem(for: product)
                self?.cartView.reloadCartUI()
            })
            present(alert, animated: true)

        case .confirmClearCart:
            let alert = UIAlertController(
                title: "알림",
                message: "장바구니를 비우시겠습니까?",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            alert.addAction(UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
                self?.cartView.cartViewModel.clearCart()
                self?.cartView.reloadCartUI()
            })
            present(alert, animated: true)
        }
    }
}
