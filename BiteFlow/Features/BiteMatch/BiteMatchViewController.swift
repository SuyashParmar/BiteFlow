import UIKit
import Combine

class BiteMatchViewController: UIViewController {
    
    private let viewModel = BiteMatchViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var cardViews: [BiteMatchCardView] = []
    
    private let containerView = UIView()
    private let matchOverlay = UIView()
    private let matchLabel = UILabel()
    private let orderButton = BFButton(title: "Add to Cart")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadFoods()
    }
    
    private func setupUI() {
        view.backgroundColor = BFColor.background
        title = "BiteMatch"
        
        let instructions = UILabel()
        instructions.text = "Swipe right on what you crave."
        instructions.font = BFFont.headline()
        instructions.textColor = BFColor.textSecondary
        instructions.textAlignment = .center
        instructions.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructions)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        setupMatchOverlay()
        
        NSLayoutConstraint.activate([
            instructions.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: BFSpacing.m),
            instructions.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            instructions.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: BFSpacing.l),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BFSpacing.xl),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -BFSpacing.xl),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -BFSpacing.xxl)
        ])
    }
    
    private func setupMatchOverlay() {
        matchOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        matchOverlay.alpha = 0
        matchOverlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(matchOverlay)
        
        let titleLabel = UILabel()
        titleLabel.text = "IT'S A MATCH!"
        titleLabel.font = BFFont.title1(weight: .black)
        titleLabel.textColor = BFColor.primary
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        matchOverlay.addSubview(titleLabel)
        
        matchLabel.font = BFFont.title3()
        matchLabel.textColor = .white
        matchLabel.textAlignment = .center
        matchLabel.numberOfLines = 0
        matchLabel.translatesAutoresizingMaskIntoConstraints = false
        matchOverlay.addSubview(matchLabel)
        
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        matchOverlay.addSubview(orderButton)
        
        let keepSwipingBtn = BFButton(title: "Keep Swiping", style: .outline)
        keepSwipingBtn.translatesAutoresizingMaskIntoConstraints = false
        keepSwipingBtn.addTarget(self, action: #selector(hideMatch), for: .touchUpInside)
        matchOverlay.addSubview(keepSwipingBtn)
        
        NSLayoutConstraint.activate([
            matchOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            matchOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            matchOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            matchOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: matchOverlay.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: matchOverlay.centerYAnchor, constant: -100),
            
            matchLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: BFSpacing.l),
            matchLabel.leadingAnchor.constraint(equalTo: matchOverlay.leadingAnchor, constant: BFSpacing.xl),
            matchLabel.trailingAnchor.constraint(equalTo: matchOverlay.trailingAnchor, constant: -BFSpacing.xl),
            
            orderButton.topAnchor.constraint(equalTo: matchLabel.bottomAnchor, constant: 50),
            orderButton.leadingAnchor.constraint(equalTo: matchOverlay.leadingAnchor, constant: BFSpacing.xl),
            orderButton.trailingAnchor.constraint(equalTo: matchOverlay.trailingAnchor, constant: -BFSpacing.xl),
            
            keepSwipingBtn.topAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: BFSpacing.m),
            keepSwipingBtn.leadingAnchor.constraint(equalTo: matchOverlay.leadingAnchor, constant: BFSpacing.xl),
            keepSwipingBtn.trailingAnchor.constraint(equalTo: matchOverlay.trailingAnchor, constant: -BFSpacing.xl)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$stack
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.loadCards(for: items)
            }
            .store(in: &cancellables)
            
        viewModel.$matchFound
            .receive(on: DispatchQueue.main)
            .sink { [weak self] match in
                if let match = match {
                    self?.showMatch(for: match)
                }
            }
            .store(in: &cancellables)
    }
    
    private func loadCards(for items: [FoodItem]) {
        cardViews.forEach { $0.removeFromSuperview() }
        cardViews.removeAll()
        
        // Add backwards so the first item is on top
        for item in items.reversed() {
            let card = BiteMatchCardView()
            card.foodItem = item
            card.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(card)
            
            NSLayoutConstraint.activate([
                card.topAnchor.constraint(equalTo: containerView.topAnchor),
                card.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                card.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                card.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            card.addGestureRecognizer(pan)
            
            cardViews.append(card)
        }
    }
    
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view as? BiteMatchCardView else { return }
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .changed:
            let rotation = (translation.x / view.bounds.width) * 0.4
            card.transform = CGAffineTransform(translationX: translation.x, y: translation.y).rotated(by: rotation)
            card.updateOverlay(translation: translation.x)
            
        case .ended:
            let velocity = sender.velocity(in: view)
            if translation.x > 100 || velocity.x > 500 {
                swipeCard(card, direction: 1) // Right
            } else if translation.x < -100 || velocity.x < -500 {
                swipeCard(card, direction: -1) // Left
            } else {
                // Reset
                UIView.animate(withDuration: 0.3) {
                    card.transform = .identity
                    card.updateOverlay(translation: 0)
                }
            }
        default:
            break
        }
    }
    
    private func swipeCard(_ card: BiteMatchCardView, direction: CGFloat) {
        guard let food = card.foodItem else { return }
        
        UIView.animate(withDuration: 0.4, animations: {
            card.transform = CGAffineTransform(translationX: direction * self.view.bounds.width * 1.5, y: 100).rotated(by: direction * 0.5)
        }) { _ in
            card.removeFromSuperview()
            self.viewModel.handleSwipe(left: direction < 0, on: food)
        }
    }
    
    private func showMatch(for item: FoodItem) {
        matchLabel.text = "You craved \(item.name)!"
        UIView.animate(withDuration: 0.3) {
            self.matchOverlay.alpha = 1
        }
    }
    
    @objc private func hideMatch() {
        UIView.animate(withDuration: 0.3) {
            self.matchOverlay.alpha = 0
        }
    }
    
    @objc private func addToCartTapped() {
        if let match = viewModel.matchFound {
            CartManager.shared.addItem(match)
            hideMatch()
            // Optionally switch to Cart tab
            tabBarController?.selectedIndex = 2
        }
    }
}
