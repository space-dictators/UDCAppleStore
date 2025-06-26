
import UIKit

import SnapKit
import Then

class CartView: UIView {
    var cartViewModel = CartViewModel()

    let totalPriceLabel = UILabel().then {
        $0.text = "Total Price : $ 1200.00"
    }

    let cancelButton = UIButton().then {
        $0.setTitle("취소하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemGray4
    }

    let purchaseButton = UIButton().then {
        $0.setTitle("구매하기", for: .normal)
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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 80)
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        cartCollectionView.register(CartItemCell.self, forCellWithReuseIdentifier: CartItemCell.reuseIdentifier)
        cartCollectionView.dataSource = self
        setupView()
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
}

// 컬렉션 뷰 프로토콜 추가
extension CartView: UICollectionViewDataSource {
    // 셀을 몇개 담을 것인가
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return cartViewModel.testCart.count
    }

    // 셀은 어떻게 담을 것인가
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CartItemCell",
            for: indexPath
        ) as? CartItemCell else {
            return UICollectionViewCell()
        }

        let item = cartViewModel.testCart[indexPath.item]
        cell.configure(with: item)
        return cell
    }
}
