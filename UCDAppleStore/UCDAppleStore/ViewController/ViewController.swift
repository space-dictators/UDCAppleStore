
import SnapKit
import Then
import UIKit

class ViewController: UIViewController {
    private var categoryView = UIView().then {
        $0.backgroundColor = .blue
    }

    private var productCollectionView = UIView().then {
        $0.backgroundColor = .systemGray2
    }

    private var cartBottomSheet = UIView().then {
        $0.backgroundColor = .orange
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBlue

//        testWithRealProductData()
    }

    func testDataService() {
        let products = DataService.shared.loadProducts()

        print("=== 데이터 로딩 테스트 ===")
        print("상품 개수: \(products.count)")

        if products.isEmpty {
            print("❌ 상품이 없습니다!")
        } else {
            print("✅ 상품 로딩 성공!")

            // 카테고리별 개수 확인
            let categories = products.map { $0.category }
            print("카테고리들: \(Set(categories))")

            // 첫 5개 상품 출력
            for product in products.prefix(5) {
                print("- \(product.name): \(product.price)원 (\(product.category))")
            }
        }
    }

//    func testWithRealProductData() {
//        // 실제 상품 데이터로 테스트
//        let products = DataService.shared.loadProducts()
//
//        guard let firstProduct = products.first else {
//            print("❌ 상품 데이터 없음")
//            return
//        }
//
//        let imageView = UIImageView(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
//        imageView.backgroundColor = .lightGray
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        view.addSubview(imageView)
//
//        // 실제 상품 이미지로 테스트
//        imageView.loadImage(from: firstProduct.imageURL)
//
//        print("🛍️ 실제 상품 이미지 테스트: \(firstProduct.name)")
//        print("URL: \(firstProduct.imageURL)")
//    }

    func setupViews() {
        view.addSubview(categoryView)
        view.addSubview(productCollectionView)
        view.addSubview(cartBottomSheet)

        categoryView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        cartBottomSheet.snp.makeConstraints {
            $0.top.equalTo(productCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(120)
        }
    }
}
