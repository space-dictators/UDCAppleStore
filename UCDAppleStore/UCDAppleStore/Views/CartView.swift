
import UIKit

import SnapKit
import Then

class CartView: UIView {
    // 테스트용 임시 카트뷰모델 생성
    private let cartViewModel = CartViewModel()

    // MARK: Properties

    weak var delegate: CartViewDelegate?

    // MARK: UI Components

    let totalPriceLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }

    let cancelButton = UIButton().then {
        $0.setTitle("초기화", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemGray4
    }

    let purchaseButton = UIButton().then {
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
    }

    let cartCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout() // 수직 스크롤형태
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16 // 셀 간 여백
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 80) // 임시 아이템 사이즈 지정
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }

    // MARK: Initailizers

    override init(frame: CGRect) {
        super.init(frame: frame)
        cartCollectionView.register(CartItemCell.self, forCellWithReuseIdentifier: CartItemCell.reuseIdentifier)
        cartCollectionView.dataSource = self
        setupView()
        setupTotalPriceText()
        setupPurchaseButtonTitle()
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup Methods

    func setupView() {
        addSubview(totalPriceLabel)
        addSubview(cancelButton)
        addSubview(purchaseButton)
        addSubview(cartCollectionView)

        // 1. 총합 레이블: 최상단에 고정
        totalPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        // 2. 하단 버튼들: 아래에 고정
        cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.trailing.equalTo(purchaseButton.snp.leading).offset(-8)
            $0.height.equalTo(44)
            $0.width.equalTo(purchaseButton)
        }

        purchaseButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        // 3. 장바구니 리스트: 총 가격 아래에 생성
        cartCollectionView.snp.makeConstraints {
            $0.top.equalTo(totalPriceLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-12)
        }
    }

    // MARK: Methods

    func setupPurchaseButtonTitle() {
        purchaseButton.setTitle(cartViewModel.purchaseButtonTitle, for: .normal)
    }

    func setupTotalPriceText() {
        totalPriceLabel.text = cartViewModel.totalPriceText
    }

    // MARK: Actions

    @objc
    private func cancelButtonTapped() {
        delegate?.cartViewDidTapCancel()
    }

    @objc
    private func purchaseButtonTapped() {
        // TODO: 프로토콜 구현시 연결
    }
}

// MARK: Extension

extension CartView: UICollectionViewDataSource {
    // MARK: Setup Methods

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return cartViewModel.testCart.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CartItemCell",
            for: indexPath
        ) as? CartItemCell else {
            return UICollectionViewCell()
        }

        let item = cartViewModel.testCart.items[indexPath.item]
        cell.configure(with: item)
        cell.onTapPlus = { [weak self] in
            self?.delegate?.cartCellDidIncreaseQuantity(for: item.product)
        }
        cell.onTapMinus = { [weak self] in
            self?.delegate?.cartCellDidDecreaseQuantity(for: item.product)
        }
        return cell
    }
}
