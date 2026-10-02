import UIKit

class HomeRestaurantCell: UITableViewCell {
    
    private let cardView = BFRestaurantCard()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: BFSpacing.m),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: BFSpacing.l),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -BFSpacing.l),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -BFSpacing.m)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.prepareForReuse()
    }
    
    func configure(with restaurant: Restaurant) {
        cardView.configure(with: restaurant)
    }
}
