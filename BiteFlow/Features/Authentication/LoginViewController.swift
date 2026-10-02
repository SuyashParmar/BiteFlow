import UIKit
import Combine

class LoginViewController: UIViewController {
    private let viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    var onLoginSuccess: (() -> Void)?
    
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = BFButton(title: "Log In")
    private let errorLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = BFColor.background
        
        let titleLabel = UILabel()
        titleLabel.text = "Welcome back to BiteFlow"
        titleLabel.font = BFFont.title2()
        titleLabel.textAlignment = .center
        
        emailField.placeholder = "Email (demo@biteflow.app)"
        emailField.borderStyle = .roundedRect
        emailField.autocapitalizationType = .none
        
        passwordField.placeholder = "Password (password123)"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        
        errorLabel.textColor = BFColor.error
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, emailField, passwordField, errorLabel, loginButton, activityIndicator])
        stack.axis = .vertical
        stack.spacing = BFSpacing.m
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BFSpacing.xl),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -BFSpacing.xl)
        ])
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    self?.loginButton.isEnabled = false
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.loginButton.isEnabled = true
                }
            }
            .store(in: &cancellables)
            
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.errorLabel.text = error
            }
            .store(in: &cancellables)
            
        viewModel.loginSuccess
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.onLoginSuccess?()
            }
            .store(in: &cancellables)
    }
    
    @objc private func loginTapped() {
        viewModel.email = emailField.text ?? ""
        viewModel.password = passwordField.text ?? ""
        viewModel.login()
    }
}
