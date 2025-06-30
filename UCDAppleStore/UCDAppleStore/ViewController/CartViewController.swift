import UIKit

import SnapKit

class CartViewController: UIViewController {
    private let cartView = CartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        sheetPresentationController?.delegate = self
    }

    private func setupUI() {
        view.backgroundColor = .background
        view.addSubview(cartView)

        cartView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }

        cartView.cartCollectionView.isHidden = true
    }

    func updateCart(items: [CartItem], totalPriceText: String, purchaseButtonTitle: String, isPurchaseEnabled: Bool) {
        cartView.reloadCartUI(
            items: items,
            totalPriceText: totalPriceText,
            purchaseButtonTitle: purchaseButtonTitle,
            isPurchaseEnabled: isPurchaseEnabled
        )
    }

    func setCartDelegate(_ delegate: CartViewDelegate) {
        cartView.delegate = delegate
    }
}

extension CartViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        let isLowHeight = sheetPresentationController.selectedDetentIdentifier == CartDetent.low.identifier

        UIView.animate(withDuration: 0.3) {
            self.cartView.cartCollectionView.isHidden = isLowHeight ? true : false
        }
    }
}
