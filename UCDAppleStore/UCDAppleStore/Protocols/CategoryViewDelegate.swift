//
//  CategoryViewDelegate.swift
//  UCDAppleStore
//
//  Created by Milou on 7/1/25.
//

import Foundation

/// CategoryView에서 누른 카테고리 버튼을 MainViewController에 알립니다.
protocol CategoryViewDelegate: AnyObject {
    /// 사용자가 카테고리 버튼을 눌렀을 때 호출됩니다
    /// - Parameter category: 선택된 카테고리 (iPhone, iPad, MacBook, Mac, Accessories)
    func categoryViewDidSelectCategory(_ category: Category)
}
