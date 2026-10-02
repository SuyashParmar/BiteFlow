import Foundation

enum HomeState {
    case idle
    case loading
    case loaded([Restaurant])
    case empty
    case error(String)
}

@MainActor
class HomeViewModel {
    private let fetchRestaurantsUseCase: FetchRestaurantsUseCaseProtocol
    
    @Published private(set) var state: HomeState = .idle
    
    init(fetchRestaurantsUseCase: FetchRestaurantsUseCaseProtocol) {
        self.fetchRestaurantsUseCase = fetchRestaurantsUseCase
    }
    
    func loadData() async {
        state = .loading
        do {
            let restaurants = try await fetchRestaurantsUseCase.execute()
            if restaurants.isEmpty {
                state = .empty
            } else {
                state = .loaded(restaurants)
            }
        } catch {
            let networkError = error as? NetworkError ?? .unknown
            state = .error(networkError.localizedDescription)
        }
    }
}
