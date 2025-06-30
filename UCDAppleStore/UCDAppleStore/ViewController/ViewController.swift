
import UIKit

class ViewController: UIViewController {
    private let productListView = ProductListView()
    private let viewModel = ProductViewModel()

    override func loadView() {
        view = productListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Products"
        bindViewModel()
        viewModel.fetchProducts()
    }

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.productListView.reload(products: self.viewModel.products)
            }
        }
    }
}
