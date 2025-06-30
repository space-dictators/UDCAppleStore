//
//  String+Localization.swift
//  UCDAppleStore
//
//  Created by Yoon on 6/30/25.
//

import Foundation

extension String {
    @inlinable static func localized(_ s: String.LocalizationValue) -> String {
        String(localized: s)
    }
}
