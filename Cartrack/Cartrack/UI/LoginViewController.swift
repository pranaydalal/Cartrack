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
        label.text = "password should contan Uppercase, Lowercase and number"
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
        label.text = "password should contan Uppercase, Lowercase and number"
        return label
    }()
    
    @IBOutlet weak var countryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func userNameTextFieldChanged(_ sender: Any) {
        if (self.userNameTextField.text ?? "").isEmpty {
            if self.userNameErrorLabel.isDescendant(of: self.userNameStackView) {
                self.userNameErrorLabel.removeFromSuperview()
            }
        } else {
            if !self.userNameErrorLabel.isDescendant(of: self.userNameStackView) {
                self.userNameStackView.addArrangedSubview(self.userNameErrorLabel)
            }
        }
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: Any) {
        if (self.passwordTextField.text ?? "").isEmpty {
            if self.passwordErrorLabel.isDescendant(of: self.passwordStackView) {
                self.passwordErrorLabel.removeFromSuperview()
            }
        } else if !self.passwordErrorLabel.isDescendant(of: self.passwordStackView) {
            self.passwordStackView.addArrangedSubview(self.passwordErrorLabel)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == countryTextField { return }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true   )
        return true
    }
}
