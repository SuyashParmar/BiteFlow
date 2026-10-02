import Foundation

struct DemoData {
    static let restaurants: [RestaurantDTO] = [
        RestaurantDTO(id: "r1", name: "Urban Spice", rating: 4.7, reviewCount: 2341, cuisine: "North Indian", deliveryTimeMin: 25, deliveryTimeMax: 30, distance: 1.8, priceRange: 2, isOpen: true, imageURL: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80", address: "123 Main St", description: "Authentic North Indian curries and tandoori."),
        RestaurantDTO(id: "r2", name: "Pizza Central", rating: 4.5, reviewCount: 1890, cuisine: "Italian", deliveryTimeMin: 35, deliveryTimeMax: 45, distance: 3.2, priceRange: 3, isOpen: true, imageURL: "https://images.unsplash.com/photo-1604381536136-57473b51bd28?auto=format&fit=crop&w=800&q=80", address: "456 Oak Ave", description: "Wood-fired pizzas and fresh pasta."),
        RestaurantDTO(id: "r3", name: "Burger Joint", rating: 4.2, reviewCount: 856, cuisine: "American", deliveryTimeMin: 15, deliveryTimeMax: 25, distance: 0.9, priceRange: 1, isOpen: true, imageURL: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80", address: "789 Pine Rd", description: "Juicy burgers and crispy fries."),
        RestaurantDTO(id: "r4", name: "Sushi Master", rating: 4.8, reviewCount: 3120, cuisine: "Japanese", deliveryTimeMin: 40, deliveryTimeMax: 55, distance: 5.5, priceRange: 4, isOpen: true, imageURL: "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=800&q=80", address: "321 Elm St", description: "Premium sushi and sashimi."),
        RestaurantDTO(id: "r5", name: "Green Bowl", rating: 4.6, reviewCount: 1245, cuisine: "Healthy", deliveryTimeMin: 20, deliveryTimeMax: 30, distance: 2.1, priceRange: 2, isOpen: true, imageURL: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=800&q=80", address: "654 Cedar Ln", description: "Fresh salads and grain bowls.")
    ]
    
    static let foods: [FoodDTO] = [
        FoodDTO(id: "f1", restaurantId: "r1", name: "Paneer Butter Masala", description: "Cottage cheese cooked in a rich tomato gravy.", price: 299.0, isVeg: true, isBestseller: true, imageURL: "https://images.unsplash.com/photo-1631452180519-c014fe946bc0?auto=format&fit=crop&w=500&q=60", categoryId: "c1"),
        FoodDTO(id: "f2", restaurantId: "r1", name: "Garlic Naan", description: "Soft bread flavored with garlic.", price: 65.0, isVeg: true, isBestseller: true, imageURL: "https://images.unsplash.com/photo-1626079933610-85fb078b668d?auto=format&fit=crop&w=500&q=60", categoryId: "c2"),
        FoodDTO(id: "f3", restaurantId: "r1", name: "Chicken Tikka", description: "Spicy grilled chicken chunks.", price: 349.0, isVeg: false, isBestseller: false, imageURL: "https://images.unsplash.com/photo-1599487405270-86430a63459c?auto=format&fit=crop&w=500&q=60", categoryId: "c3"),
        FoodDTO(id: "f4", restaurantId: "r2", name: "Margherita Pizza", description: "Classic cheese and tomato pizza.", price: 399.0, isVeg: true, isBestseller: true, imageURL: "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=500&q=60", categoryId: "c4"),
        FoodDTO(id: "f5", restaurantId: "r2", name: "Pepperoni Pizza", description: "Loaded with pepperoni and cheese.", price: 499.0, isVeg: false, isBestseller: true, imageURL: "https://images.unsplash.com/photo-1628840042765-356cda07504e?auto=format&fit=crop&w=500&q=60", categoryId: "c4")
    ]
}
