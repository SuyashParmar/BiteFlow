import UIKit
import Combine

class SearchViewModel {
    private let repository: RestaurantRepository
    
    @Published var searchText: String = ""
    @Published private(set) var results: [Restaurant] = []
    @Published private(set) var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: RestaurantRepository) {
        self.repository = repository
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }
    
    private var searchTask: Task<Void, Never>?
    
    private func performSearch(query: String) {
        searchTask?.cancel()
        
        guard !query.isEmpty else {
            results = []
            return
        }
        
        isLoading = true
        searchTask = Task {
            do {
                let allRestaurants = try await repository.fetchRestaurants()
                if Task.isCancelled { return }
                
                let filtered = allRestaurants.filter {
                    $0.name.lowercased().contains(query.lowercased()) ||
                    $0.cuisine.lowercased().contains(query.lowercased())
                }
                
                await MainActor.run {
                    self.results = filtered
                    self.isLoading = false
                }
            } catch {
                if Task.isCancelled { return }
                await MainActor.run {
                    self.results = []
                    self.isLoading = false
                    AppLogger.error("Search failed", category: .network)
                }
            }
        }
    }
}
