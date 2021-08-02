//
//  LoginViewModelTests.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 01/08/21.
//

import XCTest
@testable import Cartrack

struct MockUserDatabaseHandler: UserAccountService {
    func authenticateUser(withUserName username: String, andPassword password: String) -> Bool {
        return true
    }
    
    func registerUser(withUserName username: String, andPassword password: String, andCountry country: String) -> Bool {
        return true
    }
}

class LoginViewModelTests: XCTestCase {
    
    var viewModel : LoginViewModel!
    var mockService : MockUserDatabaseHandler!
    
    override func setUpWithError() throws {
        self.mockService = MockUserDatabaseHandler()
        self.viewModel = LoginViewModel(with: mockService)
    }

    override func tearDownWithError() throws {
        self.mockService = nil
        self.viewModel = nil
    }

    func testLoginSuccess() {
        let successExpectation = expectation(description: "success")
        self.viewModel.didLoginSuccessful = {
            successExpectation.fulfill()
        }
        self.viewModel.didLoginFailed = {
            XCTFail()
        }
        viewModel.login()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testCountry() {
        let launchExpectation = self.expectation(description: "launch")
        self.viewModel.country = "Singapore"
        self.viewModel.didLaunchCountryPicker = { country in
            XCTAssertEqual(country, "Singapore")
            launchExpectation.fulfill()
            self.viewModel.country = "Philippines"
        }
        let updateExpectation = self.expectation(description: "update")
        self.viewModel.didUpdateCountry = { country in
            XCTAssertEqual(country, "Philippines")
            updateExpectation.fulfill()
        }
        self.viewModel.selectCountry()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testLoginButtonEnabled() {
        let loginButtonExpectation = self.expectation(description: "update")
        self.viewModel.country = "India"
        self.viewModel.userName = "ABC123"
        self.viewModel.loginButtonEnableStatus = { isEnabled in
            loginButtonExpectation.fulfill()
            XCTAssertTrue(isEnabled)
        }
        self.viewModel.password = "abc@123"
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testUsernameValidationStatusValid() {
        let loginButtonExpectation = self.expectation(description: "update")
        self.viewModel.country = "India"
        self.viewModel.userName = "abc"
        self.viewModel.password = "abc@123"
        self.viewModel.userNameValidationStatus = { valid in
            loginButtonExpectation.fulfill()
            XCTAssertTrue(valid)
        }
        
        self.viewModel.userName = "ABC123"
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testPasswordValidationStatusValid() {
        let loginButtonExpectation = self.expectation(description: "update")
        self.viewModel.country = "India"
        self.viewModel.userName = "ABC123"
        self.viewModel.password = "abc"
        self.viewModel.passwordValidationStatus = { valid in
            loginButtonExpectation.fulfill()
            XCTAssertTrue(valid)
        }
        
        self.viewModel.password = "abc@123"
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
