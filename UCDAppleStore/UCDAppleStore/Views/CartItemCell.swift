
import UIKit

import SnapKit
import Then

final class CartItemCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CartItemCell"

    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    private let unitPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .right
    }

    private let minusButton = UIButton().then {
        $0.setTitle("⊖", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }

    private let quantityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .center
    }

    private let plusButton = UIButton().then {
        $0.setTitle("⊕", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }

    private let totalPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .right
    }

    private let separatorView = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    private var cellIndex: Int? // 셀의 인덱스

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: CartItem, index: Int) {
        nameLabel.text = item.product.name
        unitPriceLabel.text = "\(item.product.price)원"
        quantityLabel.text = "\(item.quantity)"
        totalPriceLabel.text = "총액: \(item.totalPrice)원"
        cellIndex = index
    }

    private func setupUI() {
        let itemList = [
            nameLabel,
            unitPriceLabel,
            minusButton,
            quantityLabel,
            plusButton,
            totalPriceLabel,
            separatorView,
        ]

        for item in itemList {
            contentView.addSubview(item)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(12)
        }

        unitPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.trailing.equalToSuperview().inset(12)
        }

        separatorView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(1)
        }

        minusButton.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.width.height.equalTo(24)
        }

        quantityLabel.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(minusButton.snp.trailing).offset(8)
        }

        plusButton.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(quantityLabel.snp.trailing).offset(8)
            $0.width.height.equalTo(24)
        }

        totalPriceLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(12)
        }
    }
}
