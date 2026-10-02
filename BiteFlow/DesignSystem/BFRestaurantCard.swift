import UIKit

class BFRestaurantCard: UIView {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    private let ratingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = BFColor.secondaryBackground
        layer.cornerRadius = BFRadius.m
        clipsToBounds = true
        
        isAccessibilityElement = true
        accessibilityTraits = .button
        
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray5
        imageView.clipsToBounds = true
        
        nameLabel.font = BFFont.headline()
        nameLabel.textColor = BFColor.textPrimary
        
        infoLabel.font = BFFont.caption()
        infoLabel.textColor = BFColor.textSecondary
        infoLabel.numberOfLines = 1
        
        ratingLabel.font = BFFont.callout(weight: .semibold)
        ratingLabel.textColor = BFColor.textPrimary
        
        let vStack = UIStackView(arrangedSubviews: [nameLabel, infoLabel])
        vStack.axis = .vertical
        vStack.spacing = 2
        
        let hStack = UIStackView(arrangedSubviews: [vStack, ratingLabel])
        hStack.axis = .horizontal
        hStack.alignment = .top
        hStack.distribution = .equalSpacing
        
        let mainStack = UIStackView(arrangedSubviews: [imageView, hStack])
        mainStack.axis = .vertical
        mainStack.spacing = BFSpacing.s
        
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 140),
            
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -BFSpacing.m),
            
            hStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: BFSpacing.m),
            hStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -BFSpacing.m)
        ])
    }
    
    private var imageLoadingTask: Task<Void, Never>?
    
    func configure(with restaurant: Restaurant) {
        nameLabel.text = restaurant.name
        infoLabel.text = "\(restaurant.cuisine) • \(restaurant.deliveryTimeRange)"
        ratingLabel.text = "★ \(restaurant.rating)"
        
        accessibilityLabel = "\(restaurant.name). \(restaurant.cuisine). Rating \(restaurant.rating) stars."
        
        imageView.image = nil
        
        // Cancel previous image task if reused
        imageLoadingTask?.cancel()
        
        if let url = restaurant.imageURL {
            imageLoadingTask = Task { [weak self] in
                let image = await ImageService.shared.loadImage(from: url)
                if !Task.isCancelled {
                    await MainActor.run {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }
    
    func prepareForReuse() {
        imageLoadingTask?.cancel()
        imageView.image = nil
    }
}
