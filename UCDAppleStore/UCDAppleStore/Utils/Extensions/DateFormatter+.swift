//
//  DateFormatter+.swift
//  UCDAppleStore
//
//  Created by Milou on 6/25/25.
//

import Foundation

extension DateFormatter {
    static let longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar.current
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
