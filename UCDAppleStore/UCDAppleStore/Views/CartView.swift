
import UIKit

import SnapKit
import Then

class CartView: UIView {
    private let cartViewModel = CartViewModel()

    let totalPriceLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }

    let cancelButton = UIButton().then {
        $0.setTitle("취소하기", for: .normal)
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        cartCollectionView.register(CartItemCell.self, forCellWithReuseIdentifier: CartItemCell.reuseIdentifier)
        cartCollectionView.dataSource = self
        setupView()
        setupView()
        setupTotalPriceText()
        setupPurchaseButtonTitle()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        addSubview(totalPriceLabel)
        addSubview(cancelButton)
        addSubview(purchaseButton)
        addSubview(cartCollectionView)

        totalPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(totalPriceLabel.snp.bottom).offset(8)
            $0.trailing.equalTo(self.snp.centerX).offset(-32)
        }
        purchaseButton.snp.makeConstraints {
            $0.top.equalTo(totalPriceLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.snp.centerX).offset(32)
        }
        cartCollectionView.snp.makeConstraints {
            $0.top.equalTo(purchaseButton.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }

    func setupPurchaseButtonTitle() {
        purchaseButton.setTitle(cartViewModel.purchaseButtonTitle, for: .normal)
    }

    func setupTotalPriceText() {
        totalPriceLabel.text = cartViewModel.totalPriceText
    }
}

extension CartView: UICollectionViewDataSource {
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
        cell.configure(with: item, index: indexPath.item)
        return cell
    }
}
