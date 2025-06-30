import UIKit

enum CartDetent: String, CaseIterable {
    case low
    case middle
    case high

    var detent: UISheetPresentationController.Detent {
        switch self {
        case .low:
            return .custom(identifier: .init(rawValue)) { _ in 120 }
        case .middle:
            return .custom(identifier: .init(rawValue)) { context in
                context.maximumDetentValue * 0.3
            }
        case .high:
            return .large()
        }
    }

    var identifier: UISheetPresentationController.Detent.Identifier {
        switch self {
        case .low, .middle:
            return .init(rawValue)
        case .high:
            return .large
        }
    }
}
