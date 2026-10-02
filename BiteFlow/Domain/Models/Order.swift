import Foundation

enum OrderStatus: String, Codable {
    case placed = "PLACED"
    case confirmed = "CONFIRMED"
    case preparing = "PREPARING"
    case outForDelivery = "OUT_FOR_DELIVERY"
    case delivered = "DELIVERED"
    case cancelled = "CANCELLED"
}

struct Order: Identifiable, Codable {
    let id: String
    let restaurantId: String
    let items: [OrderLineItem]
    let status: OrderStatus
    let totalAmount: Double
    let createdAt: Date
}

struct OrderLineItem: Codable {
    let foodId: String
    let name: String
    let quantity: Int
    let price: Double
}
