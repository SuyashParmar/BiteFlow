import UIKit
import Combine

class FoodAssistantViewController: UIViewController {
    private let viewModel = FoodAssistantViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let promptTextField = UITextField()
    private let askButton = BFButton(title: "Ask AI")
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        title = "What should I eat?"
        view.backgroundColor = BFColor.background
        
        promptTextField.placeholder = "e.g., spicy and vegetarian under ₹300"
        promptTextField.borderStyle = .roundedRect
        promptTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(promptTextField)
        
        askButton.translatesAutoresizingMaskIntoConstraints = false
        askButton.addTarget(self, action: #selector(askTapped), for: .touchUpInside)
        view.addSubview(askButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            promptTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: BFSpacing.m),
            promptTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BFSpacing.m),
            promptTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -BFSpacing.m),
            
            askButton.topAnchor.constraint(equalTo: promptTextField.bottomAnchor, constant: BFSpacing.m),
            askButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BFSpacing.m),
            askButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -BFSpacing.m),
            
            tableView.topAnchor.constraint(equalTo: askButton.bottomAnchor, constant: BFSpacing.m),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$isReasoning
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isReasoning in
                if isReasoning {
                    self?.activityIndicator.startAnimating()
                    self?.askButton.isEnabled = false
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.askButton.isEnabled = true
                }
            }
            .store(in: &cancellables)
            
        viewModel.$recommendations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @objc private func askTapped() {
        promptTextField.resignFirstResponder()
        guard let text = promptTextField.text else { return }
        viewModel.askRecommendation(prompt: text)
    }
}

extension FoodAssistantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recommendations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = viewModel.recommendations[indexPath.row]
        cell.textLabel?.text = "\(item.name) - ₹\(item.price)"
        return cell
    }
}
