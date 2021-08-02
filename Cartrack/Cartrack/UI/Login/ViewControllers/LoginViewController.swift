//
//  LoginViewController.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 27/07/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Constants
    
    /// Storyboard Identifier to load ViewController
    static let storyboardIdentifier = "LoginViewController"
    
    // MARK:IBOutlets
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            self.loginButton.layer.cornerRadius = 4
            self.loginButton.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var userNameStackView: UIStackView!
    @IBOutlet weak var userNameTextField: UITextField! {
        didSet {
            self.userNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.delegate = self
        }
    }
    
    @IBOutlet weak var countryTextField: UITextField! {
        didSet {
            self.countryTextField.delegate = self
        }
    }
    
    // MARK: Private properties
    
    private var userNameErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.numberOfLines = 0
        label.font = label.font.withSize(10)
        label.text = "User name must have at least 5 characters and can only contain alphabets and numbers"
        return label
    }()
    
    private var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.numberOfLines = 0
        label.font = label.font.withSize(10)
        label.text = "Password must have at least 7 characters with at least one Alphabet, one Number and one Symbol"
        return label
    }()
    
    private let loginViewModel = LoginViewModel(with: UserDatabaseHandler.shared())
    
    // MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindViewModel()
    }
    
    // MARK: IBActions methods
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.loginViewModel.login()
    }
    
    @IBAction func userNameTextFieldChanged(_ sender: Any) {
        self.loginViewModel.userName = self.userNameTextField.text ?? ""
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: Any) {
        self.loginViewModel.password = self.passwordTextField.text ?? ""
    }
    
    // MARK: Private methods
    
    private func bindViewModel() {
        self.loginViewModel.didLoginFailed = { [weak self] in
            guard let _self = self else { return }
            _self.launchLoginFailed()
        }
        
        self.loginViewModel.didLoginSuccessful = { [weak self] in
            guard let _self = self else { return }
            _self.launchLoginSuccess()
        }
        
        self.loginViewModel.loginButtonEnableStatus = { [weak self] isEnabled in
            guard let _self = self else { return }
            _self.loginButton.isUserInteractionEnabled = isEnabled
            _self.loginButton.backgroundColor = isEnabled ? UIColor.systemBlue : UIColor.systemGray2
        }
        
        self.loginViewModel.userNameValidationStatus = { [weak self] isValid in
            guard let _self = self else { return }
            if isValid {
                if _self.userNameErrorLabel.isDescendant(of: _self.userNameStackView) {
                    _self.userNameErrorLabel.removeFromSuperview()
                }
            } else {
                if !_self.userNameErrorLabel.isDescendant(of: _self.userNameStackView) {
                    _self.userNameStackView.addArrangedSubview(_self.userNameErrorLabel)
                }
            }
        }
        
        self.loginViewModel.passwordValidationStatus = { [weak self] isValid in
            guard let _self = self else { return }
            if isValid {
                if _self.passwordErrorLabel.isDescendant(of: _self.passwordStackView) {
                    _self.passwordErrorLabel.removeFromSuperview()
                }
            } else if !_self.passwordErrorLabel.isDescendant(of: _self.passwordStackView) {
                _self.passwordStackView.addArrangedSubview(_self.passwordErrorLabel)
            }
        }
        
        self.loginViewModel.didLaunchCountryPicker = { [weak self] country in
            guard let _self = self else { return }
            
            _self.launchCountryPicker(country)
        }
        
        self.loginViewModel.didUpdateCountry = { [weak self] country in
            guard let _self = self else { return }
            
            _self.countryTextField.text = country
        }
    }
    
    private func launchCountryPicker(_ country: String) {
        let countryPickerviewController = CountryPickerViewController()
        countryPickerviewController.modalPresentationStyle = .overCurrentContext
        countryPickerviewController.modalTransitionStyle = .crossDissolve
        countryPickerviewController.delegate = self
        countryPickerviewController.selectCountryIfAvailable(country: country)
        self.present(countryPickerviewController, animated: true, completion: nil)
    }
    
    private func launchLoginFailed() {
        let alert = UIAlertController(title: "Incorrect username or password", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func launchLoginSuccess() {
        let usersListViewController = UsersListViewController()
        let navigationController = UINavigationController(rootViewController: usersListViewController)
        
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = navigationController
    }
}

// MARK: - Text Field delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard textField == self.countryTextField else {
            return true
        }
        self.loginViewModel.selectCountry()
        return false
    }
}

// MARK: - Country picker delegate

extension LoginViewController: CountryPickerViewControllerDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerViewController, didSelectCountry country: String) {
        self.loginViewModel.country = country
    }
}
