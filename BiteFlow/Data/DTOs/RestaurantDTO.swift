import Foundation

struct RestaurantDTO: Codable {
    let id: String
    let name: String
    let rating: Double
    let reviewCount: Int
    let cuisine: String
    let deliveryTimeMin: Int
    let deliveryTimeMax: Int
    let distance: Double
    let priceRange: Int
    let isOpen: Bool
    let imageURL: String
    let address: String
    let description: String
}

struct FoodDTO: Codable {
    let id: String
    let restaurantId: String
    let name: String
    let description: String
    let price: Double
    let isVeg: Bool
    let isBestseller: Bool
    let imageURL: String
    let categoryId: String
}
