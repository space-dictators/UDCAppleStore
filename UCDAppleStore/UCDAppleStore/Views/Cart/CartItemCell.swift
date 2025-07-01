
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

    // 상단 스택뷰
    private let topRowStackView = UIStackView().then {
        $0.axis = .horizontal // 수평 정렬
        $0.spacing = 8 // name과 price 사이 여백
        $0.alignment = .center // 수직 중앙 정렬
        $0.distribution = .fill // 너비는 내용물에 맞게 분배
    }

    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .ucdText
    }

    private let unitPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .right
        $0.textColor = .ucdText
    }

    // 하단 스택뷰
    private let bottomRowStackView = UIStackView().then {
        $0.axis = .horizontal // 수평 정렬
        $0.spacing = 8 // name과 price 사이 여백
        $0.alignment = .center // 수직 중앙 정렬
    }

    private let minusButton = UIButton().then {
        let configuration = UIImage.SymbolConfiguration(pointSize: 24)
        $0.setImage(UIImage(systemName: "minus.circle", withConfiguration: configuration), for: .normal)
        $0.tintColor = .ucdText
    }

    private let quantityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textAlignment = .center
        $0.textColor = .ucdText
    }

    private let plusButton = UIButton().then {
        let configuration = UIImage.SymbolConfiguration(pointSize: 24)
        $0.setImage(UIImage(systemName: "plus.circle", withConfiguration: configuration), for: .normal)
        $0.tintColor = .ucdText
    }

    private let totalPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textAlignment = .right
    }

    private let separatorView = UIView().then {
        $0.backgroundColor = .ucdText
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
        contentView.backgroundColor = .ucdCartCell
        contentView.layer.cornerRadius = 12

        // 상단 스택뷰
        topRowStackView.addArrangedSubview(nameLabel)
        topRowStackView.addArrangedSubview(unitPriceLabel)
        contentView.addSubview(topRowStackView)

        // 길이가 충돌할만큼 긴 경우를 위해 hugging compression 설정
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        unitPriceLabel.setContentHuggingPriority(.required, for: .horizontal)
        unitPriceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        contentView.addSubview(separatorView)

        // 하단 스택뷰
        bottomRowStackView.addArrangedSubview(minusButton)
        bottomRowStackView.addArrangedSubview(quantityLabel)
        bottomRowStackView.addArrangedSubview(plusButton)
        contentView.addSubview(bottomRowStackView)

        contentView.addSubview(totalPriceLabel)

        // 오토 레이아웃 설정

        topRowStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview().inset(12)
        }

        separatorView.snp.makeConstraints {
            $0.top.equalTo(topRowStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(1)
        }

        bottomRowStackView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().inset(12).priority(.low)
        }

        minusButton.snp.makeConstraints { $0.size.equalTo(40) }
        plusButton.snp.makeConstraints { $0.size.equalTo(40) }
        quantityLabel.snp.makeConstraints { $0.width.equalTo(32) }

        totalPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(bottomRowStackView)
            $0.trailing.equalToSuperview().inset(12)
        }
    }

    func configure(with item: CartItem) {
        nameLabel.text = item.product.name
        unitPriceLabel.text = .localized("\(item.product.price.formattedWithComma)원")
        quantityLabel.text = "\(item.quantity)"
        totalPriceLabel.text = .localized("\(item.totalPrice.formattedWithComma)원")
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
