
import UIKit

import SnapKit

final class CartItemCell: UICollectionViewCell {
    static let reuseIdentifier = "CartItemCell"

    private let nameLabel = UILabel()
    private let quantityLabel = UILabel()
    private let totalPriceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: CartItem) {
        nameLabel.text = item.product.name
        quantityLabel.text = "수량: \(item.quantity)"
        totalPriceLabel.text = "총액: \(item.totalPrice)원"
    }

    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(totalPriceLabel)

        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8)
        }

        quantityLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(8)
        }

        totalPriceLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(8)
        }
    }
}
