//
//  Protocols.swift
//  UCDAppleStore
//
//  Created by Milou on 6/26/25.
//

import Foundation

/// CategoryView에서 누른 카테고리 버튼을 MainViewController에 알립니다.
protocol CategoryViewDelegate: AnyObject {
    /// 사용자가 카테고리 버튼을 눌렀을 때 호출됩니다
    /// - Parameter category: 선택된 카테고리 (iPhone, iPad, MacBook, Mac, Accessories)
    func categoryViewDidSelectCategory(_ category: Category)
}

/// ProductView에서 카트에 담긴 상품을 MainViewController에 알립니다.
protocol ProductViewDelegate: AnyObject {
    /// 사용자가 상품의 장바구니 버튼을 탭했을 때 호출됩니다
    /// - Parameter product: 장바구니에 추가할 상품 정보
    func productViewDidTapAddToCart(_ product: Product)
}

/// CartCell에서 상품 수량 변경(+,-)을 MainViewController에 알립니다.
/// CartView에서 취소를 MainViewController에 알립니다.
protocol CartViewDelegate: AnyObject {
    /// 사용자가 장바구니 아이템의 수량 증가 버튼(⊕)을 탭했을 때 호출됩니다
    /// - Parameter product: 수량을 증가시킬 상품
    func cartCellDidIncreaseQuantity(for product: Product)
    /// 사용자가 장바구니 아이템의 수량 감소 버튼(⊖)을 탭했을 때 호출됩니다
    /// - Parameter product: 수량을 감소시킬 상품 (0이 되면 장바구니에서 제거됨)
    func cartCellDidDecreaseQuantity(for product: Product)
    /// 사용자가 취소하기 버튼을 탭했을 때 호출됩니다
    /// 장바구니의 모든 아이템이 제거됩니다
    func cartViewDidTapCancel()
    /// 예외처리 발생시 Alert 발생을 알려줍니다
    func cartViewShouldShowAlert(_ alertType: CartAlertType)
}
