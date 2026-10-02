import Foundation
import Combine

class FoodAssistantViewModel {
    private let recommendationService: FoodRecommendationService
    
    @Published var recommendations: [FoodItem] = []
    @Published var isReasoning: Bool = false
    @Published var error: String?
    
    init(recommendationService: FoodRecommendationService = DemoFoodRecommendationService()) {
        self.recommendationService = recommendationService
    }
    
    func askRecommendation(prompt: String) {
        guard !prompt.isEmpty else { return }
        
        isReasoning = true
        error = nil
        
        Task {
            do {
                let results = try await recommendationService.recommendFood(prompt: prompt)
                await MainActor.run {
                    self.recommendations = results
                    self.isReasoning = false
                }
            } catch {
                await MainActor.run {
                    self.error = "Could not fetch recommendations at this time."
                    self.isReasoning = false
                }
            }
        }
    }
}
