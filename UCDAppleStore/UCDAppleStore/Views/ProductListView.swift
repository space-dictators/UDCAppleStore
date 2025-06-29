//
//  ProductListView.swift
//  UCDAppleStore
//
//  Created by 이서린 on 6/27/25.
//

import SnapKit
import Then
import UIKit

class ProductListView: UIView {
    private var products: [Product] = []
    private var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }

    // 🔁 외부에서 products 배열을 전달받고 갱신하는 메서드
    func reload(products: [Product]) {
        self.products = products
        collectionView.reloadData()
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

            return section
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .white
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
            $0.dataSource = self
        }

        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - DataSource

extension ProductListView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }

        let product = products[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}
