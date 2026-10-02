import Foundation

class CartCalculator {
    let deliveryFee: Double = 49.0
    let taxRate: Double = 0.05
    
    func calculateTotal(subtotal: Double, discount: Double = 0) -> Double {
        let afterDiscount = max(0, subtotal - discount)
        let taxes = afterDiscount * taxRate
        return afterDiscount + deliveryFee + taxes
    }
}
