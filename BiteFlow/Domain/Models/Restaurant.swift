import Foundation

struct Restaurant: Identifiable, Equatable {
    let id: String
    let name: String
    let rating: Double
    let reviewCount: Int
    let cuisine: String
    let deliveryTimeRange: String
    let distance: Double
    let priceRange: Int
    let isOpen: Bool
    let imageURL: URL?
    let address: String
    let description: String
}

struct FoodItem: Identifiable, Equatable {
    let id: String
    let restaurantId: String
    let name: String
    let description: String
    let price: Double
    let isVeg: Bool
    let isBestseller: Bool
    let imageURL: URL?
    let categoryId: String
}
