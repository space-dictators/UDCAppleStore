
import UIKit

import SnapKit
import Then

class CartView: UIView {
    // MARK: Properties

    private var cartItems: [CartItem] = []
    weak var delegate: CartViewDelegate?

    // MARK: UI Components

    let totalPriceLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .ucdText
        $0.textAlignment = .right
    }

    let resetButton = UCDButton(style: .reset)
    let purchaseButton = UCDButton(style: .checkout)

    // TODO: UICollectionViewCompositionalLayout -> ListLayout으로 변경
    let cartCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout() // 수직 스크롤형태
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16 // 셀 간 여백
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }

    // MARK: Initailizers

    override init(frame: CGRect) {
        super.init(frame: frame)
        cartCollectionView.register(CartItemCell.self, forCellWithReuseIdentifier: CartItemCell.reuseIdentifier)
        cartCollectionView.dataSource = self
        cartCollectionView.delegate = self
        setupView()
        resetButton.setTitle = .localized("초기화")
        resetButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup Methods

    func setupView() {
        addSubview(totalPriceLabel)
        addSubview(resetButton)
        addSubview(purchaseButton)
        addSubview(cartCollectionView)

        // 1. 총합 레이블: 최상단에 고정
        totalPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(16)
        }

        // 2. 하단 버튼들: 아래에 고정
        resetButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(40)
            $0.trailing.equalTo(purchaseButton.snp.leading).offset(-8)
            $0.height.equalTo(44)
            $0.width.equalTo(purchaseButton)
        }

        purchaseButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(44)
        }

        // 3. 장바구니 리스트: 총 가격 아래에 생성
        cartCollectionView.snp.makeConstraints {
            $0.top.equalTo(totalPriceLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(resetButton.snp.top).offset(-12)
        }
    }

    // MARK: Methods

    // 장바구니 리로드 함수 추가
    func reloadCartUI(items: [CartItem], totalPriceText: String, purchaseButtonTitle: String, isPurchaseEnabled: Bool) {
        cartItems = items
        cartCollectionView.reloadData()
        totalPriceLabel.text = totalPriceText
        purchaseButton.setTitle = purchaseButtonTitle
        purchaseButton.isEnabled = isPurchaseEnabled
        purchaseButton.alpha = isPurchaseEnabled ? 1.0 : 0.5
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
        return cartItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CartItemCell",
            for: indexPath
        ) as? CartItemCell else {
            return UICollectionViewCell()
        }

        let item = cartItems[indexPath.item]
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

// TODO: UICollectionViewCompositionalLayout -> ListLayout 으로 변경시에는 삭제
extension CartView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width, height: 102
        )
    }
}
