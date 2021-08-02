//
//  UsersListViewModelTests.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 02/08/21.
//

import XCTest
@testable import Cartrack

class UsersListWebServiceMock: WebService {
    
    var response: String = ""
    
    required init(baseURL: URL, networkSession: NetworkSession) { }
    
    func fetchUsersList(_ completion: @escaping ((Result<[User], Error>) -> Void)) {
        print(self.response)
        guard let extractedExpr = try? JSONDecoder().decode([User].self, from: Data(self.response.utf8)) else {
            completion(.failure(NetworkErrors.ParsingError.unableToParse))
            return
        }
        completion(.success(extractedExpr))
    }
}

class UsersListViewModelTests: XCTestCase {

    private static let usersListResponse = """
                [
                    {
                        \"id\": 1,
                        \"name\": \"Leanne Graham\",
                        \"username\": \"Bret\",
                        \"email\": \"Sincere@april.biz\",
                        \"address\": {
                          \"street\": \"Kulas Light\",
                          \"suite\": \"Apt. 556\",
                          \"city\": \"Gwenborough\",
                          \"zipcode\": \"92998-3874\",
                          \"geo\": {
                            \"lat\": \"-37.3159\",
                            \"lng\": \"81.1496\"
                          }
                        },
                        \"phone\": \"1-770-736-8031 x56442\",
                        \"website\": \"hildegard.org\",
                        \"company\": {
                          \"name\": \"Romaguera-Crona\",
                          \"catchPhrase\": \"Multi-layered client-server neural-net\",
                          \"bs\": \"harness real-time e-markets\"
                        }
                    }
                ]
                """
    
    func testFetchingUsersSuccess() {
        let usersListWebservice = UsersListWebServiceMock(baseURL: URL(string: "xyz.com")!, networkSession: NetworkSessionMock())
        let viewModel = UsersListViewModel(with: usersListWebservice)
        usersListWebservice.response = type(of: self).usersListResponse
        let startLoadingExpectation = expectation(description: "Start Loading")
        viewModel.didstartLoading = {
            startLoadingExpectation.fulfill()
        }
        
        let endLoadingExpectation = self.expectation(description: "End Loading")
        viewModel.didEndLoading = {
            endLoadingExpectation.fulfill()
        }

        let reloadUsersListExpectation = self.expectation(description: "Reload Users List Expectations")
        viewModel.didReloadUsersListData = { users in
            reloadUsersListExpectation.fulfill()
            XCTAssert(users?.count ?? 0 > 0)
        }
        
        viewModel.fetchUsers()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testNoMoreUsersAvailable() {
        let usersListWebservice = UsersListWebServiceMock(baseURL: URL(string: "xyz.com")!, networkSession: NetworkSessionMock())
        let viewModel = UsersListViewModel(with: usersListWebservice)
        usersListWebservice.response = "[]"
        let startLoadingExpectation = self.expectation(description: "Start Loading")
        viewModel.didstartLoading = {
            startLoadingExpectation.fulfill()
        }
        
        let endLoadingExpectation = self.expectation(description: "End Loading")
        viewModel.didEndLoading = {
            endLoadingExpectation.fulfill()
        }
        
        let reloadUsersListExpectation = self.expectation(description: "Reload Users List Expectations")
        viewModel.didReloadUsersListData = { users in
            reloadUsersListExpectation.fulfill()
            XCTAssert(users?.count == 0)
        }
        
        viewModel.fetchUsers()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testErrorFetchingUsers() {
        let usersListWebservice = UsersListWebServiceMock(baseURL: URL(string: "xyz.com")!, networkSession: NetworkSessionMock())
        let viewModel = UsersListViewModel(with: usersListWebservice)
        usersListWebservice.response = ""
        
        let errorExpectation = self.expectation(description: "Error Loading")
        viewModel.didShowError = { _ in
            errorExpectation.fulfill()
        }
        
        viewModel.didReloadUsersListData = { users in
            XCTFail()
        }
        
        viewModel.fetchUsers()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testUserSelectedWithData() {
        let usersListWebservice = UsersListWebServiceMock(baseURL: URL(string: "xyz.com")!, networkSession: NetworkSessionMock())
        let viewModel = UsersListViewModel(with: usersListWebservice)
        usersListWebservice.response = type(of: self).usersListResponse
        let startLoadingExpectation = expectation(description: "User Selected")
        viewModel.didUserSelected = { user in
            startLoadingExpectation.fulfill()
            XCTAssertNotNil(user)
        }
        
        let reloadUsersListExpectation = self.expectation(description: "Reload Users List Expectations")
        viewModel.didReloadUsersListData = { users in
            reloadUsersListExpectation.fulfill()
            viewModel.userSelected(at: 0)
        }

        viewModel.fetchUsers()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testUserSelectedWithZeroData() {
        let usersListWebservice = UsersListWebServiceMock(baseURL: URL(string: "xyz.com")!, networkSession: NetworkSessionMock())
        let viewModel = UsersListViewModel(with: usersListWebservice)
        usersListWebservice.response = "[]"
        viewModel.didUserSelected = { user in
            XCTFail()
        }
        
        let reloadUsersListExpectation = self.expectation(description: "Reload Users List Expectations")
        viewModel.didReloadUsersListData = { users in
            reloadUsersListExpectation.fulfill()
            viewModel.userSelected(at: 0)
        }

        viewModel.fetchUsers()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testUserSelectedWithNoData() {
        let usersListWebservice = UsersListWebServiceMock(baseURL: URL(string: "xyz.com")!, networkSession: NetworkSessionMock())
        let viewModel = UsersListViewModel(with: usersListWebservice)
        usersListWebservice.response = ""
        viewModel.didUserSelected = { user in
            XCTFail()
        }
        
        let endLoadingExpectation = self.expectation(description: "End Loading")
        viewModel.didEndLoading = {
            endLoadingExpectation.fulfill()
            viewModel.userSelected(at: 0)
        }
        
        viewModel.didReloadUsersListData = { users in
            XCTFail()
        }
        viewModel.fetchUsers()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
