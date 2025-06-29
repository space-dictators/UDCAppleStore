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
        $0.tintColor = .black
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
        addSubview(bottomStack)

        // StackView 구성
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(priceLabel)

        bottomStack.addArrangedSubview(infoStack)
        bottomStack.addArrangedSubview(cartButton)

        // 이미지
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.6)
        }

        // 아래쪽 Stack
        bottomStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }

        cartButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }

    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) 원"
        imageView.loadImage(from: product.imageURL)
    }
}
