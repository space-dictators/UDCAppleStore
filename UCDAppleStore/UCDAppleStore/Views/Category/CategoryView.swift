import SnapKit
import Then
import UIKit

class CategoryView: UIView {
    // MARK: - Properties

    private var categories: [Category] = Category.allCategories
    private var categoryButtons: [UCDButton] = []

    weak var delegate: CategoryViewDelegate?

    // MARK: - UI Components

    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }

    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        createCategoryButtons()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods

    private func setupUI() {
        backgroundColor = .ucdBackground

        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.horizontalEdges.height.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: - Private Methods

    private func createCategoryButtons() {
        categoryButtons.forEach { $0.removeFromSuperview() }
        categoryButtons.removeAll()

        for (index, category) in categories.enumerated() {
            let button = UCDButton(style: .category).then {
                $0.setTitle = category.titleName
                $0.tag = index
                $0.addTarget(
                    self,
                    action: #selector(categoryButtonDidTap(_:)),
                    for: .touchUpInside
                )
            }
            categoryButtons.append(button)
            stackView.addArrangedSubview(button)
        }
    }

    func updateUI(selectedCategory: Category) {
        for (index, button) in categoryButtons.enumerated() {
            if categories[index] == selectedCategory {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }

    // MARK: - Actions

    @objc
    private func categoryButtonDidTap(_ sender: UCDButton) {
        let selectedCategory = categories[sender.tag]
        delegate?.categoryViewDidSelectCategory(selectedCategory)
    }
}

@available(iOS 17.0, *)
#Preview {
    CategoryView()
}
