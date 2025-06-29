
import UIKit

import SnapKit
import Then

/// 앱 전체에서 사용하는 통합 버튼 컴포넌트입니다
///
/// 사용법
/// ```swift
/// // 초기화 버튼
/// let resetButton = UCDButton(style: .reset)
/// resetButton.setTitle = "초기화"
///
/// // 결제 버튼
/// let checkoutButton = UCDButton(style: .checkout)
/// checkoutButton.setTitle = "결제하기"
class UCDButton: UIControl {
    private let background: UIView
    private var titleLabel: UILabel
    private let padding: UIEdgeInsets
    private let style: Style

    var setTitle: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    override var intrinsicContentSize: CGSize {
        let textSize = titleLabel.intrinsicContentSize
        return CGSize(
            width: textSize.width + padding.left + padding.right,
            height: textSize.height + padding.top + padding.bottom
        )
    }

    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1
        }
    }

    override var isSelected: Bool {
        didSet {
            updateBackgroundForSelection()
        }
    }

    init(style: Style) {
        self.style = style

        background = switch style {
        case .category:
            CategoryBackgroundView()
        case .reset:
            ResetBackgroundView()
        case .checkout:
            CheckoutBackgroundView()
        }

        titleLabel = UILabel().then {
            $0.font = style.font
            $0.textColor = style.titleColor
            $0.textAlignment = .center
        }

        padding = style.padding

        super.init(frame: .zero)
        addSubview(background)
        addSubview(titleLabel)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        background.frame = bounds
        titleLabel.frame = bounds
    }

    private func updateBackgroundForSelection() {
        if case .category = style {
            if let categoryBackground = background as? CategoryBackgroundView {
                categoryBackground.backgroundColor = isSelected ? .systemBlue : .cartCell
            }
        }
    }
}

extension UCDButton {
    private class CategoryBackgroundView: UIView {
        override func willMove(toSuperview newSuperview: UIView?) {
            super.willMove(toSuperview: newSuperview)
            isUserInteractionEnabled = false
            backgroundColor = .cartCell
            layer.cornerRadius = 16
        }
    }

    private class ResetBackgroundView: UIView {
        override func willMove(toSuperview newSuperview: UIView?) {
            super.willMove(toSuperview: newSuperview)
            isUserInteractionEnabled = false
            backgroundColor = .cancelButton
            layer.cornerRadius = 20
        }
    }

    private class CheckoutBackgroundView: UIView {
        override func willMove(toSuperview newSuperview: UIView?) {
            super.willMove(toSuperview: newSuperview)
            isUserInteractionEnabled = false
            backgroundColor = .accent
            layer.cornerRadius = 20
        }
    }
}

extension UCDButton {
    enum Style {
        case category
        case reset
        case checkout

        var titleColor: UIColor {
            switch self {
            case .category:
                return .text
            case .reset, .checkout:
                return .white
            }
        }

        var font: UIFont {
            switch self {
            case .category:
                return .systemFont(ofSize: 14, weight: .semibold)
            case .reset, .checkout:
                return .systemFont(ofSize: 18, weight: .bold)
            }
        }

        var padding: UIEdgeInsets {
            switch self {
            case .category:
                return .init(top: 8, left: 12, bottom: 8, right: 12)
            case .reset, .checkout:
                return .init(top: 8, left: 24, bottom: 8, right: 24)
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    let stackView = UIStackView(
        arrangedSubviews: [
            UCDButton(style: .category).then {
                $0.setTitle = "iPhone"
            },
            UCDButton(style: .reset).then {
                $0.setTitle = "초기화"
            },
            UCDButton(style: .checkout).then {
                $0.setTitle = "결제하기"
            },
        ]
    )
    stackView.axis = .vertical
    stackView.spacing = 20
    return stackView
}
