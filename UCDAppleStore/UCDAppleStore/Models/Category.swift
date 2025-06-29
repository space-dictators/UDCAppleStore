
import Foundation

enum Category: String, Codable, CaseIterable {
    case iphone
    case ipad
    case macBook = "MacBook"
    case mac = "Mac"
    case accessories = "Accessories"

    var titleName: String {
        switch self {
        case .iphone:
            return "iPhone"
        case .ipad:
            return "iPad"
        case .macBook:
            return "MacBook"
        case .mac:
            return "Mac"
        case .accessories:
            return "Accessories"
        }
    }

    static var allCategories: [Category] {
        return Category.allCases
    }
}
