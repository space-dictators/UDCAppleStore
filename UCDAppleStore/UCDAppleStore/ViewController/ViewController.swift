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
        productListView.delegate = self
        bindViewModel()
        viewModel.fetchProducts()
    }

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.productListView.reloadData()
            }
        }
    }
}

extension ViewController: ProductListViewDelegate {
    func numberOfItems() -> Int {
        return viewModel.numberOfItems()
    }

    func product(at index: Int) -> Product? {
        return viewModel.product(at: index)
    }
}
