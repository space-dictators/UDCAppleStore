import SnapKit
import Then
import UIKit

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Products"
        view.backgroundColor = .white

        setupCollectionView()
        bindViewModel()

        viewModel.fetchProducts()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout().then {
            $0.itemSize = CGSize(width: view.frame.width / 2 - 16, height: 250)
            $0.minimumLineSpacing = 16
            $0.minimumInteritemSpacing = 8
            $0.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .white
            $0.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
            $0.dataSource = self
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let product = viewModel.product(at: indexPath.item),
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: product)
        return cell
    }
}
