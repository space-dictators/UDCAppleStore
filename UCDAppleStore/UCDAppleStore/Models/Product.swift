
import Foundation

struct Product: Codable, Hashable {
    let id: UUID
    let name: String
    let category: Category
    let price: Int
    let imageURL: URL
}
