import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let window: UIWindow
    
    // Dependencies
    private let apiClient: APIClientProtocol
    private let restaurantRepository: RestaurantRepository
    private let fetchRestaurantsUseCase: FetchRestaurantsUseCaseProtocol
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        
        // Initialize dependencies (In a real app, use a DI container)
        if AppEnvironment.current.isDemoMode {
            self.apiClient = MockAPIClient()
        } else {
            self.apiClient = APIClient()
        }
        
        self.restaurantRepository = RestaurantRepositoryImpl(apiClient: self.apiClient)
        self.fetchRestaurantsUseCase = FetchRestaurantsUseCase(repository: self.restaurantRepository)
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showSplash()
    }
    
    private func showSplash() {
        let splashVC = UIViewController()
        splashVC.view.backgroundColor = BFColor.primary
        
        let label = UILabel()
        label.text = "BiteFlow"
        label.textColor = .white
        label.font = BFFont.title1(weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        splashVC.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: splashVC.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: splashVC.view.centerYAnchor)
        ])
        
        navigationController.setViewControllers([splashVC], animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            if AuthService.shared.isLoggedIn {
                self?.showHome()
            } else {
                self?.showLogin()
            }
        }
    }
    
    private func showLogin() {
        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = { [weak self] in
            self?.showHome()
        }
        navigationController.setViewControllers([loginVC], animated: true)
    }
    
    private func showHome() {
        let tabBarVC = MainTabBarController(fetchRestaurantsUseCase: fetchRestaurantsUseCase)
        // Hide the coordinator's nav bar since tabs have their own
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([tabBarVC], animated: true)
    }
}
