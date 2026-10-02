import Foundation

struct RestaurantMapper {
    static func map(dto: RestaurantDTO) -> Restaurant {
        return Restaurant(
            id: dto.id,
            name: dto.name,
            rating: dto.rating,
            reviewCount: dto.reviewCount,
            cuisine: dto.cuisine,
            deliveryTimeRange: "\(dto.deliveryTimeMin)-\(dto.deliveryTimeMax) min",
            distance: dto.distance,
            priceRange: dto.priceRange,
            isOpen: dto.isOpen,
            imageURL: URL(string: dto.imageURL),
            address: dto.address,
            description: dto.description
        )
    }
}

struct FoodMapper {
    static func map(dto: FoodDTO) -> FoodItem {
        return FoodItem(
            id: dto.id,
            restaurantId: dto.restaurantId,
            name: dto.name,
            description: dto.description,
            price: dto.price,
            isVeg: dto.isVeg,
            isBestseller: dto.isBestseller,
            imageURL: URL(string: dto.imageURL),
            categoryId: dto.categoryId
        )
    }
}
