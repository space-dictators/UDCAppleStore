import UIKit

import SnapKit
import Then

class MainViewController: UIViewController {
    // MARK: - Properties

    private let cartView = CartView()
    private let productView = UIView().then {
        $0.backgroundColor = .ucdBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
        presentCartView()
    }

    func setupBaseUI() {
        view.backgroundColor = .ucdBackground
        title = " UCD Apple Store"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    // MARK: - Public Methods

    func presentCartView() {
        let cartViewController = CartViewController()

        if let sheet = cartViewController.sheetPresentationController {
            sheet.detents = [CartDetent.low, CartDetent.middle, CartDetent.high].map { $0.detent }
            sheet.selectedDetentIdentifier = CartDetent.low.identifier // 초기 높이
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false // 내부 뷰 스크롤로 시트 확장
            sheet.largestUndimmedDetentIdentifier = .large
            cartViewController.isModalInPresentation = true
        }
        present(cartViewController, animated: true)
    }
}
