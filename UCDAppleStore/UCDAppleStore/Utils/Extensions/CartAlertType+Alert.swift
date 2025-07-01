//
//  CartAlertType+Alert.swift
//  UCDAppleStore
//
//  Created by Milou on 6/30/25.
//

import UIKit

extension CartAlertType {
    func showAlert(on viewController: UIViewController, completion: ((Product?) -> Void)? = nil) {
        switch self {
        case .quantityLimitExceeded:
            let alert = UIAlertController(
                title: .localized("알림"),
                message: .localized("한 품목당 구입 가능한 최대 수량은 10개입니다."),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: .localized("확인"), style: .default))
            viewController.present(alert, animated: true)

        case let .confirmRemoveItem(product):
            let alert = UIAlertController(
                title: .localized("알림"),
                message: .localized("\(product.name)을 삭제하시겠습니까?"),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: .localized("취소"), style: .cancel))
            alert.addAction(UIAlertAction(title: .localized("삭제"), style: .destructive) { _ in
                completion?(product)
            })
            viewController.present(alert, animated: true)

        case .confirmClearCart:
            let alert = UIAlertController(
                title: .localized("알림"),
                message: .localized("장바구니를 전부 비우시겠습니까?"),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: .localized("취소"), style: .cancel))
            alert.addAction(UIAlertAction(title: .localized("확인"), style: .destructive) { _ in
                completion?(nil)
            })
            viewController.present(alert, animated: true)
        }
    }
}
