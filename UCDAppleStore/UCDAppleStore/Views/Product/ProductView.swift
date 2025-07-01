import Kingfisher
import SnapKit
import Then
import UIKit

class ProductView: UIView {
    // 이미지 컨테이너 뷰 추가
    private let imageContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }

    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }

    private let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }

    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .systemGray
        $0.textAlignment = .left
    }

    private let cartButton = UIButton(type: .system).then {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        let image = UIImage(systemName: "cart", withConfiguration: config)
        $0.setImage(image, for: .normal)
        $0.tintColor = .ucdText
    }

    private let infoStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
    }

    private let bottomStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }

    var onCartButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(imageContainerView)
        addSubview(bottomStack)

        imageContainerView.addSubview(imageView)

        // StackView 구성
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(priceLabel)

        bottomStack.addArrangedSubview(infoStack)
        bottomStack.addArrangedSubview(cartButton)

        // 이미지 컨테이너 - 셀 전체 너비로 확장
        imageContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(bottomStack.snp.top).offset(-8)
        }

        // 이미지뷰 - 컨테이너 내에서 적당한 크기로 중앙 배치
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.8)
        }

        // 아래쪽 Stack
        bottomStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
            make.height.equalTo(54)
        }

        cartButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }

        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }

    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = .localized("\(product.price.formattedWithComma)원")
        imageView.loadImage(from: product.imageURL)
    }

    @objc
    private func cartButtonTapped() {
        onCartButtonTapped?()
    }
}
