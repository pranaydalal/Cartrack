//
//  LoginViewModel.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 29/07/21.
//

import Foundation

final class LoginViewModel {
    
    private let accountService : UserAccountService
    
    private var isUserNameValid: Bool {
        return self.userName.count > 3
    }
    
    private var isPasswordValid: Bool {
        return self.password.count > 3
    }
    
    var didUpdateCountry:((String)->())?
    var didLaunchCountryPicker:((String)->())?
    
    var didLoginSuccessful:(()->())?
    var didLoginFailed:(()->())?
    
    var userNameValidationStatus:((Bool)->())?
    var passwordValidationStatus:((Bool)->())?
    
    var loginButtonEnableStatus:((Bool)->())?
    
    var userName:String = "" {
        didSet {
            self.userNameValidationStatus?(self.userName.count > 3 || self.userName.count == 0)
            self.updateLoginButtonEnableStatus()
        }
    }
    
    var password:String = "" {
        didSet {
            self.passwordValidationStatus?(self.password.count > 3 || self.password.count == 0)
            self.updateLoginButtonEnableStatus()
        }
    }
    
    required init(with accountService: UserAccountService) {
        self.accountService = accountService
    }
    
    private func updateLoginButtonEnableStatus() {
        self.loginButtonEnableStatus?(self.isUserNameValid && self.isPasswordValid)
    }
    
    func login() {
        if self.accountService.authenticateUser(withUserName: self.userName, andPassword: self.password) {
            self.didLoginSuccessful?()
        } else {
            self.didLoginFailed?()
        }
    }
    
    func selectCountry() {
//        self.didLaunchCountryPicker?(country)
    }
    
}
