import UIKit

final class ImageService {
    static let shared = ImageService()
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 50 // 50 MB
    }
    
    func loadImage(from url: URL) async -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                cache.setObject(image, forKey: url as NSURL, cost: data.count)
                return image
            }
        } catch {
            // Task might be cancelled when scrolling
            if (error as? URLError)?.code != .cancelled {
                AppLogger.error("Failed to load image: \(error.localizedDescription)", category: .network)
            }
        }
        return nil
    }
}
