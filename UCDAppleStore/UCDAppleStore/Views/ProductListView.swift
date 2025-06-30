import SnapKit
import Then
import UIKit

class ProductListView: UIView {
    // MARK: - Properties

    private var products: [Product] = []
    private var paddedProducts: [Product?] = []
    private var collectionView: UICollectionView!
    private let pageControl = UIPageControl()

    weak var delegate: ProductListViewDelegate?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Public

    func reload(products: [Product]) {
        self.products = products

        // 4의 배수로 맞추기 위해 nil로 padding
        let remainder = products.count % 4
        let padding = remainder == 0 ? 0 : 4 - remainder
        paddedProducts = products.map { Optional($0) } + Array(repeating: nil, count: padding)

        collectionView.reloadData()

        let pages = Int(ceil(Double(products.count) / 4.0))
        pageControl.numberOfPages = pages
        pageControl.currentPage = 0
    }

    // MARK: - Private

    private func setupUI() {
        setupCollectionView()

        addSubview(collectionView)
        addSubview(pageControl)

        // 페이지 인디케이터 스타일 설정
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.hidesForSinglePage = true
        pageControl.isUserInteractionEnabled = false

        // Layout
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(pageControl.snp.top).offset(-8)
        }

        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(220)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { _, environment -> NSCollectionLayoutSection? in
            let screenWidth = environment.container.effectiveContentSize.width
            let horizontalInsets: CGFloat = 8 * 2
            let interItemSpacing: CGFloat = 4
            let availableWidth = screenWidth - horizontalInsets - interItemSpacing
            let itemWidth = availableWidth / 2

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidth),
                heightDimension: .absolute(itemWidth)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

            let horizontalGroupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(screenWidth - horizontalInsets),
                heightDimension: .absolute(itemWidth)
            )
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: horizontalGroupSize,
                subitem: item,
                count: 2
            )
            horizontalGroup.interItemSpacing = .fixed(interItemSpacing)

            let verticalGroupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(screenWidth - horizontalInsets),
                heightDimension: .absolute(itemWidth * 2 + interItemSpacing)
            )
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: verticalGroupSize,
                subitems: [horizontalGroup, horizontalGroup]
            )
            verticalGroup.interItemSpacing = .fixed(interItemSpacing)

            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

            section.visibleItemsInvalidationHandler = { [weak self] _, offset, env in
                guard let self = self else { return }
                let page = Int(round(offset.x / env.container.contentSize.width))
                if page != self.pageControl.currentPage {
                    self.pageControl.currentPage = page
                }
            }

            return section
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .background
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.alwaysBounceVertical = false
            $0.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
            $0.dataSource = self
            $0.delegate = self
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ProductListView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return paddedProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }

        if let product = paddedProducts[indexPath.item] {
            cell.isHidden = false
            cell.configure(with: product)
            cell.onCartButtonTapped = { [weak self] in
                self?.delegate?.productViewDidTapAddToCart(product)
            }
        } else {
            cell.isHidden = true // 빈 셀 숨기기
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ProductListView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        pageControl.currentPage = currentPage
    }
}
