
import UIKit

import SnapKit
import Then

final class CartView: UIView {
    
    let totalPriceLabel = UILabel().then {
        $0.text = "$ 1200.00"
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소하기", for: .normal)
    }
    
    let purchaseButton = UIButton().then {
        $0.setTitle( "구매하기", for: .normal)
    }
    
    let cartCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then{
        let layout = UICollectionViewFlowLayout() // 수직 스크롤형태
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16 // 셀 간 여백
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // 셀 높이 자동조절
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
}
