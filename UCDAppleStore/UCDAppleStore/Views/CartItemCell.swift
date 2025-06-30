
import UIKit

import SnapKit
import Then

final class CartItemCell: UICollectionViewCell {
    // MARK: - Constants

    static let reuseIdentifier = "CartItemCell"

    // MARK: Closures

    var onTapPlus: (() -> Void)?
    var onTapMinus: (() -> Void)?

    // MARK: UI Components

    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    private let unitPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .right
    }

    private let minusButton = UIButton().then {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        $0.setImage(UIImage(systemName: "minus.circle", withConfiguration: configuration), for: .normal)
        $0.tintColor = .black
    }

    private let quantityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textAlignment = .center
    }

    private let plusButton = UIButton().then {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        $0.setImage(UIImage(systemName: "plus.circle", withConfiguration: configuration), for: .normal)
        $0.tintColor = .black
    }

    private let totalPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .right
    }

    private let separatorView = UIView().then {
        $0.backgroundColor = .systemGray4
        $0.tintColor = .black
    }

    // MARK: Initailizers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup Methods

    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12

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
            $0.width.equalTo(28)
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

    func configure(with item: CartItem) {
        nameLabel.text = item.product.name
        unitPriceLabel.text = "\(item.product.price.formattedWithComma)원"
        quantityLabel.text = "\(item.quantity)"
        totalPriceLabel.text = "\(item.totalPrice.formattedWithComma)원"
    }

    // MARK: Actions

    @objc
    private func plusButtonTapped() {
        onTapPlus?()
    }

    @objc
    private func minusButtonTapped() {
        onTapMinus?()
    }
}
