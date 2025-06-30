import UIKit

import SnapKit
import Then

class MainViewController: UIViewController {
    // MARK: - Properties

    private let categoryViewModel = CategoryViewModel()
    private let productViewModel = ProductViewModel()
    private let cartViewModel = CartViewModel()

    private var categoryView = CategoryView()
    private var productListView = ProductListView()
    private var cartView = CartView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModels()
        loadInitialData()
        presentCartView()
    }

    // MARK: - Private Methods

    private func bindViewModels() {
        categoryViewModel.onCategoryChanged = { [weak self] category in
            DispatchQueue.main.async {
                print("Category changed to: \(category)")

                self?.categoryView.updateUI(selectedCategory: category)
                self?.productViewModel.filterProducts(by: category)
            }
        }

        productViewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                let products = self?.productViewModel.products ?? []
                self?.productListView.reload(products: products)
            }
        }
    }

    private func loadInitialData() {
        productViewModel.fetchProducts()
    }

    // MARK: - Setup Methods

    private func setupViews() {
        view.backgroundColor = .background
        setupNavigationBar()
        setupCategoryView()
        setupProductListView()
    }

    private func setupNavigationBar() {
        title = " UCD Apple Store"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    private func setupCategoryView() {
        categoryView.delegate = self
        view.addSubview(categoryView)

        categoryView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(44)
        }

        categoryViewModel.onCategoryChanged?(.iphone)
    }

    private func setupProductListView() {
        view.addSubview(productListView)

        productListView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
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

extension MainViewController: CategoryViewDelegate {
    func categoryViewDidSelectCategory(_ category: Category) {
        categoryViewModel.selectCategory(category)
    }
}

extension MainViewController: CartViewDelegate {
    func cartViewShouldShowAlert(_: CartAlertType) {
        print("alertClicked")
    }

    func cartCellDidIncreaseQuantity(for product: Product) {
        cartViewModel.increaseQuantiy(for: product)
    }

    func cartCellDidDecreaseQuantity(for product: Product) {
        cartViewModel.decreaseQuantiy(for: product)
    }

    func cartViewDidTapCancel() {
        cartViewModel.clearCart()
    }
}
