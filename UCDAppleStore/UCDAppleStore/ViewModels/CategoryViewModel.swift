import Foundation

class CategoryViewModel {
    // MARK: - Properties

    private(set) var categories: [Category] = Category.allCases
    private(set) var selectedCategory: Category = .iphone

    // MARK: - UI Update Closures

    var onCategoriesLoaded: (([Category]) -> Void)?
    var onCategoryChanged: ((Category) -> Void)?

    // MARK: - Public Methods

    func loadCategories() {
        onCategoriesLoaded?(categories)
    }

    func selectCategory(_ category: Category) {
        selectedCategory = category
        onCategoryChanged?(selectedCategory)
    }
}
