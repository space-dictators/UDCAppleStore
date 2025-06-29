//
//  ProductView.swift
//  UCDAppleStore
//
//  Created by 이서린 on 6/26/25.
//

import Kingfisher 
import SnapKit
import Then
import UIKit

class ProductView: UIView {
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }

    private let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }

    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .systemGray
        $0.textAlignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.6)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.right.equalTo(nameLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }
    }

    func configure(with product: Product) {
        // 이름과 가격 설정
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) 원"

        // 이미지 로드 - 익스텐션 활용
        imageView.loadImage(from: product.imageURL)
    }
}
