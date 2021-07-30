//
//  LoginViewController.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 27/07/21.
//

import UIKit

class LoginViewController: UIViewController {

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
    
    private var userNameErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.numberOfLines = 0
        label.font = label.font.withSize(10)
        label.text = "User name should only contain characters and numbers"
        return label
    }()
    
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.delegate = self
        }
    }
    private var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.numberOfLines = 0
        label.font = label.font.withSize(10)
        label.text = "Password should contan Uppercase, Lowercase and number"
        return label
    }()
    
    @IBOutlet weak var countryTextField: UITextField! {
        didSet {
            self.countryTextField.delegate = self
        }
    }
    
    private let loginViewModel = LoginViewModel(with: UserDatabaseHandler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindViewModel()
    }

    func bindViewModel() {
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
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.loginViewModel.login()
    }
    
    @IBAction func userNameTextFieldChanged(_ sender: Any) {
        self.loginViewModel.userName = self.userNameTextField.text ?? ""
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: Any) {
        self.loginViewModel.password = self.passwordTextField.text ?? ""
    }
    
    func launchLoginFailed() {
        let alert = UIAlertController(title: "Incorrect username or password", message: nil, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "loginFailed"
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func launchLoginSuccess() {
        let alert = UIAlertController(title: "Login Success", message: nil, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "loginSuccess"
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

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
