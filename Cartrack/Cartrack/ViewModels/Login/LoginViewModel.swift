//
//  LoginViewModel.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 29/07/21.
//

import Foundation

final class LoginViewModel {
    
    // MARK: Callbacks or observers
    
    var didUpdateCountry: ((String)->())?
    var didLaunchCountryPicker: ((String)->())?
    
    var didLoginSuccessful: (()->())?
    var didLoginFailed: (()->())?
    
    var userNameValidationStatus: ((Bool)->())?
    var passwordValidationStatus: ((Bool)->())?
    
    var loginButtonEnableStatus: ((Bool)->())?
    
    //MARK: Private properties
    
    private let accountService : UserAccountService
    
    private var isUserNameValid: Bool {
        return self.userName.doesMatchRegex("^[0-9a-zA-Z]{5,}$")
    }
    
    private var isPasswordValid: Bool {
        return self.password.doesMatchRegex("^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{7,}$")
    }
    
    //MARK: Public properties
    
    /// User name to be used to login
    var userName: String = "" {
        didSet {
            self.userNameValidationStatus?(self.isUserNameValid || self.userName.count == 0)
            self.updateLoginButtonEnableStatus()
        }
    }
    
    /// Password to be used to login
    var password: String = "" {
        didSet {
            self.passwordValidationStatus?(self.isPasswordValid || self.password.count == 0)
            self.updateLoginButtonEnableStatus()
        }
    }
    
    /// Country to be used to login
    var country : String = "" {
        didSet {
            self.didUpdateCountry?(country)
            self.updateLoginButtonEnableStatus()
        }
    }
    
    //MARK: Initializers
    
    /**
     To initialize with data service
     
     - parameter accountService: Data service to be used for authentication operations
     */
    required init(with accountService: UserAccountService) {
        self.accountService = accountService
    }
    
    //MARK: Private methods
    
    private func updateLoginButtonEnableStatus() {
        self.loginButtonEnableStatus?(self.isUserNameValid && self.isPasswordValid && !self.country.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    //MARK: Public methods
    
    /// To check is user credentials are authentic
    func login() {
        if self.accountService.authenticateUser(withUserName: self.userName, andPassword: self.password) {
            self.didLoginSuccessful?()
        } else {
            self.didLoginFailed?()
        }
    }
    
    /// To launch country selection view
    func selectCountry() {
        self.didLaunchCountryPicker?(country)
    }
}
