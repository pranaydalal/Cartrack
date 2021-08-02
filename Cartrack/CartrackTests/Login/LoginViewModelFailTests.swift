//
//  LoginViewModelFailTests.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 01/08/21.
//

import XCTest

@testable import Cartrack

class UserDatabaseFailingHandlerMock: UserAccountService {
    func authenticateUser(withUserName username: String, andPassword password: String) -> Bool {
        return false
    }
    
    func registerUser(withUserName username: String, andPassword password: String, andCountry country: String) -> Bool {
        return false
    }
}

class LoginViewModelFailTests: XCTestCase {
    
    var viewModel : LoginViewModel!
    var mockService : UserDatabaseFailingHandlerMock!
    
    override func setUpWithError() throws {
        self.mockService = UserDatabaseFailingHandlerMock()
        self.viewModel = LoginViewModel(with: mockService)
    }

    override func tearDownWithError() throws {
        self.mockService = nil
        self.viewModel = nil
    }

    func testLoginFailed() {
        let failExpectation = expectation(description: "fail")
        viewModel.didLoginSuccessful = {
            XCTFail()
        }
        viewModel.didLoginFailed = {
            failExpectation.fulfill()
        }
        viewModel.login()
        waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testLoginButtonDisabled() {
        let loginButtonExpectation = self.expectation(description: "update")
        self.viewModel.country = "India"
        self.viewModel.userName = "ABC123"
        self.viewModel.loginButtonEnableStatus = { isEnabled in
            loginButtonExpectation.fulfill()
            XCTAssertFalse(isEnabled)
        }
        self.viewModel.password = "abc"
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testUsernameValidationStatusInvalid() {
        let loginButtonExpectation = self.expectation(description: "update")
        self.viewModel.country = "India"
        self.viewModel.userName = "ABC123"
        self.viewModel.password = "abc@123"
        self.viewModel.userNameValidationStatus = { valid in
            loginButtonExpectation.fulfill()
            XCTAssertFalse(valid)
        }
        
        self.viewModel.userName = "abc"
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testPasswordValidationStatusInvalid() {
        let loginButtonExpectation = self.expectation(description: "update")
        self.viewModel.country = "India"
        self.viewModel.userName = "ABC123"
        self.viewModel.password = "abc@123"
        self.viewModel.passwordValidationStatus = { valid in
            loginButtonExpectation.fulfill()
            XCTAssertFalse(valid)
        }
        
        self.viewModel.password = "abc"
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
