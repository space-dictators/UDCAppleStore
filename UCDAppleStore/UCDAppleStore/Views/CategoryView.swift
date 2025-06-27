import SnapKit
import Then
import UIKit

class CategoryView: UIView {
    // MARK: - Properties

    private let viewModel = CategoryViewModel()
    private var categories: [Category] = Category.allCategories
    private var categoryButtons: [UIButton] = []

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
        backgroundColor = .background

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
            let button = UIButton(type: .system).then {
                $0.setTitle(category.titleName, for: .normal)
                $0.backgroundColor = .white
                $0.setTitleColor(.label, for: .normal)
                $0.layer.cornerRadius = 20
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
        updateButtons(selectedCategory: viewModel.selectedCategory)
    }

    private func updateButtons(selectedCategory: Category) {
        for (index, button) in categoryButtons.enumerated() {
            if categories[index] == selectedCategory {
                button.backgroundColor = .systemBlue
            } else {
                button.backgroundColor = .white
            }
        }
    }

    // MARK: - Actions

    @objc
    private func categoryButtonDidTap(_ sender: UIButton) {
        let selectedCategory = categories[sender.tag]
        viewModel.selectCategory(selectedCategory)
        updateButtons(selectedCategory: viewModel.selectedCategory)
        delegate?.categoryViewDidSelectCategory(selectedCategory)
    }
}
