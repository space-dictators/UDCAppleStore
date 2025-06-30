//
//  CartViewDelegate.swift
//  UCDAppleStore
//
//  Created by Milou on 7/1/25.
//

import Foundation

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
