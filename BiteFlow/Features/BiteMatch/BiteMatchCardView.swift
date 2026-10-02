import UIKit

class BiteMatchCardView: UIView {
    
    private let imageView = UIImageView()
    private let overlayView = UIView()
    private let nameLabel = UILabel()
    private let likeLabel = UILabel()
    private let nopeLabel = UILabel()
    
    var foodItem: FoodItem? {
        didSet {
            nameLabel.text = foodItem?.name
            if let url = foodItem?.imageURL {
                Task {
                    let image = await ImageService.shared.loadImage(from: url)
                    await MainActor.run {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = BFRadius.xl
        clipsToBounds = true
        backgroundColor = BFColor.secondaryBackground
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        // Gradient overlay for text readability
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overlayView)
        
        nameLabel.font = BFFont.title1(weight: .heavy)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        setupStamp(label: likeLabel, text: "LIKE", color: BFColor.success, angle: -0.2)
        setupStamp(label: nopeLabel, text: "NOPE", color: BFColor.error, angle: 0.2)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BFSpacing.xl),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -BFSpacing.xl),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -BFSpacing.xl),
            
            likeLabel.topAnchor.constraint(equalTo: topAnchor, constant: BFSpacing.xxl),
            likeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BFSpacing.xl),
            
            nopeLabel.topAnchor.constraint(equalTo: topAnchor, constant: BFSpacing.xxl),
            nopeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -BFSpacing.xl)
        ])
    }
    
    private func setupStamp(label: UILabel, text: String, color: UIColor, angle: CGFloat) {
        label.text = text
        label.font = BFFont.title1(weight: .black)
        label.textColor = color
        label.layer.borderWidth = 4
        label.layer.borderColor = color.cgColor
        label.layer.cornerRadius = BFRadius.s
        label.textAlignment = .center
        label.transform = CGAffineTransform(rotationAngle: angle)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        // Padding
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func updateOverlay(translation: CGFloat) {
        let threshold: CGFloat = 50
        if translation > 0 {
            likeLabel.alpha = min(translation / threshold, 1.0)
            nopeLabel.alpha = 0
        } else if translation < 0 {
            nopeLabel.alpha = min(abs(translation) / threshold, 1.0)
            likeLabel.alpha = 0
        } else {
            likeLabel.alpha = 0
            nopeLabel.alpha = 0
        }
    }
}
