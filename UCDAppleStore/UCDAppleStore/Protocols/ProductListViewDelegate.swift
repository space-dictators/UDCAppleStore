//
//  ProductListViewDelegate.swift
//  UCDAppleStore
//
//  Created by Milou on 7/1/25.
//

import Foundation

/// ProductView에서 카트에 담긴 상품을 MainViewController에 알립니다.
protocol ProductListViewDelegate: AnyObject {
    /// 사용자가 상품의 장바구니 버튼을 탭했을 때 호출됩니다
    /// - Parameter product: 장바구니에 추가할 상품 정보
    func productViewDidTapAddToCart(_ product: Product)
}
