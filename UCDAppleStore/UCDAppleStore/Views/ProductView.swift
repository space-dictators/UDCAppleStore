//
//  ProductView.swift
//  UCDAppleStore
//
//  Created by 이서린 on 6/26/25.
//

import SnapKit
import Then
import UIKit

class ProductView: UIView {
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.numberOfLines = 2
    }

    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemGray
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
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.snp.width) // 정사각형 이미지
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.right.bottom.equalToSuperview()
        }
    }

    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) 원"

        // 이미지 로드 (간단히 URL -> Data 로딩, 실제론 비동기 라이브러리 추천)
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: product.imageURL),
               let image = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "photo")
                }
            }
        }
    }
}
