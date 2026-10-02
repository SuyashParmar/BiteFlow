import UIKit

class MainTabBarController: UITabBarController {
    
    private let fetchRestaurantsUseCase: FetchRestaurantsUseCaseProtocol
    
    init(fetchRestaurantsUseCase: FetchRestaurantsUseCaseProtocol) {
        self.fetchRestaurantsUseCase = fetchRestaurantsUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = BFColor.primary
        tabBar.backgroundColor = BFColor.background
        
        setupTabs()
    }
    
    private func setupTabs() {
        let homeVM = HomeViewModel(fetchRestaurantsUseCase: fetchRestaurantsUseCase)
        let homeVC = HomeViewController(viewModel: homeVM)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let searchVM = SearchViewModel(repository: (fetchRestaurantsUseCase as! FetchRestaurantsUseCase).repository)
        let searchVC = SearchViewController(viewModel: searchVM)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let cartVC = CartViewController()
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 2)
        
        let biteMatchVC = BiteMatchViewController()
        biteMatchVC.tabBarItem = UITabBarItem(title: "BiteMatch", image: UIImage(systemName: "flame"), tag: 3)
        
        let aiVC = FoodAssistantViewController()
        aiVC.tabBarItem = UITabBarItem(title: "Assistant", image: UIImage(systemName: "sparkles"), tag: 4)
        
        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: searchVC),
            UINavigationController(rootViewController: cartVC),
            UINavigationController(rootViewController: biteMatchVC),
            UINavigationController(rootViewController: aiVC)
        ]
    }
}
