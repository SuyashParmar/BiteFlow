import UIKit
import Combine

class CartViewController: UIViewController {
    private let viewModel = CartViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let tableView = UITableView()
    private let totalLabel = UILabel()
    private let checkoutButton = BFButton(title: "Proceed to Checkout")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        title = "Your Cart"
        view.backgroundColor = BFColor.background
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CartCell")
        view.addSubview(tableView)
        
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = BFColor.secondaryBackground
        view.addSubview(bottomView)
        
        totalLabel.font = BFFont.title3()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(totalLabel)
        
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(checkoutButton)
        checkoutButton.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 120),
            
            totalLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: BFSpacing.m),
            totalLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: BFSpacing.l),
            
            checkoutButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: BFSpacing.l),
            checkoutButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -BFSpacing.l),
            checkoutButton.bottomAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.bottomAnchor, constant: -BFSpacing.m)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
            
        viewModel.$total
            .receive(on: DispatchQueue.main)
            .sink { [weak self] total in
                self?.totalLabel.text = String(format: "Total: ₹%.2f", total)
            }
            .store(in: &cancellables)
    }
    
    @objc private func checkoutTapped() {
        let checkoutVC = UIViewController()
        checkoutVC.title = "Checkout"
        checkoutVC.view.backgroundColor = BFColor.background
        navigationController?.pushViewController(checkoutVC, animated: true)
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)
        let item = viewModel.items[indexPath.row]
        cell.textLabel?.text = "\(item.quantity)x \(item.foodItem.name) - ₹\(item.totalPrice)"
        return cell
    }
}
