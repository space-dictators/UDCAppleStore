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
    private var cartViewController: CartViewController?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModels()
        loadInitialData()
        setupViews()
        presentCartView()
    }

    // MARK: - Private Methods

    private func bindViewModels() {
        categoryViewModel.onCategoriesLoaded = { [weak self] categories in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.categoryView.updateCategories(categories)
                self.categoryView.updateUI(selectedCategory: self.categoryViewModel.selectedCategory)
            }
        }

        categoryViewModel.onCategoryChanged = { [weak self] category in
            DispatchQueue.main.async {
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

        cartViewModel.onCartUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateCartView()
            }
        }

        cartViewModel.onAlertTriggered = { [weak self] alertType in
            DispatchQueue.main.async {
                self?.handleCartAlert(alertType)
            }
        }
    }

    private func loadInitialData() {
        categoryViewModel.loadCategories()
        productViewModel.fetchProducts()
        productViewModel.filterProducts(by: categoryViewModel.selectedCategory)
    }

    // MARK: - Setup Methods

    private func setupViews() {
        view.backgroundColor = .ucdBackground
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
    }

    private func setupProductListView() {
        productListView.delegate = self
        view.addSubview(productListView)

        productListView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func updateCartView() {
        cartViewController?.updateCart(
            items: cartViewModel.cartItems,
            totalPriceText: cartViewModel.totalPriceText,
            purchaseButtonTitle: cartViewModel.purchaseButtonTitle,
            isPurchaseEnabled: cartViewModel.isPurchaseAvailable
        )
    }

    private func handleCartAlert(_ alertType: CartAlertType) {
        guard let cartViewController = cartViewController else { return }

        alertType.showAlert(on: cartViewController) { [weak self] product in
            if let product = product {
                self?.cartViewModel.removeItem(for: product)
            } else {
                self?.cartViewModel.clearCart()
            }
        }
    }

    // MARK: - Public Methods

    func presentCartView() {
        let cartVC = CartViewController()
        cartViewController = cartVC

        cartVC.setCartDelegate(self)
        cartVC.updateCart(
            items: cartViewModel.cartItems,
            totalPriceText: cartViewModel.totalPriceText,
            purchaseButtonTitle: cartViewModel.purchaseButtonTitle,
            isPurchaseEnabled: cartViewModel.isPurchaseAvailable
        )

        if let sheet = cartVC.sheetPresentationController {
            sheet.detents = [CartDetent.low, CartDetent.middle, CartDetent.high].map { $0.detent }
            sheet.selectedDetentIdentifier = CartDetent.low.identifier // 초기 높이
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false // 내부 뷰 스크롤로 시트 확장
            sheet.largestUndimmedDetentIdentifier = .large
            cartVC.isModalInPresentation = true
        }
        present(cartVC, animated: true)
    }
}

extension MainViewController: CategoryViewDelegate {
    func categoryViewDidSelectCategory(_ category: Category) {
        categoryViewModel.selectCategory(category)
    }
}

extension MainViewController: ProductListViewDelegate {
    func productViewDidTapAddToCart(_ product: Product) {
        let cartItem = CartItem(product: product, quantity: 1)
        cartViewModel.addCartItem(cartItem)
    }
}

extension MainViewController: CartViewDelegate {
    func cartViewShouldShowAlert(_ alertType: CartAlertType) {
        handleCartAlert(alertType)
    }

    func cartCellDidIncreaseQuantity(for product: Product) {
        cartViewModel.increaseQuantiy(for: product)
    }

    func cartCellDidDecreaseQuantity(for product: Product) {
        cartViewModel.decreaseQuantiy(for: product)
    }

    func cartViewDidTapCancel() {
        handleCartAlert(.confirmClearCart)
    }
}
