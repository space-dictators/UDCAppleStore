
import Foundation

struct Product: Codable, Hashable {
    let id: Int
    let name: String
    let category: Category
    let price: Int
    let imageURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case price
        case imageURL = "img_url"
    }
}
