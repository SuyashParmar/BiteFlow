import UIKit

class BFButton: UIButton {
    
    enum Style {
        case primary
        case secondary
        case outline
    }
    
    private let style: Style
    
    init(title: String, style: Style = .primary) {
        self.style = style
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = BFFont.headline()
        layer.cornerRadius = BFRadius.m
        
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        switch style {
        case .primary:
            backgroundColor = BFColor.primary
            setTitleColor(.white, for: .normal)
        case .secondary:
            backgroundColor = BFColor.secondary
            setTitleColor(.white, for: .normal)
        case .outline:
            backgroundColor = .clear
            setTitleColor(BFColor.primary, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = BFColor.primary.cgColor
        }
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1.0
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
