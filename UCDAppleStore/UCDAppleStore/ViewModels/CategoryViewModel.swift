import Foundation

class CategoryViewModel {
    // MARK: - Properties

    private(set) var selectedCategory: Category = .iphone

    // MARK: - UI Update Closures

    var onCategoryChanged: ((Category) -> Void)?

    // MARK: - Public Methods

    func selectCategory(_ category: Category) {
        selectedCategory = category
        onCategoryChanged?(selectedCategory)
    }
}
