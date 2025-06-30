//
//  ProductCell.swift
//  UCDAppleStore
//
//  Created by 이서린 on 6/26/25.
//
import SnapKit
import Then
import UIKit

class ProductCell: UICollectionViewCell {
    private let productView = ProductView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productView)
        productView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .cell
        contentView.clipsToBounds = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with product: Product) {
        productView.configure(with: product)
    }
}
