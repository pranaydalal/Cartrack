//
//  UsersListRequestTests.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 28/07/21.
//

import XCTest

@testable import Cartrack

class UsersListRequestTests: XCTestCase {
    
    var mock: NetworkSessionMock!
    
    override func setUpWithError() throws {
        self.mock = NetworkSessionMock()
    }

    override func tearDownWithError() throws {
        self.mock = nil
    }

    func testExpectSuccessFullResponseWhenValidJSONIsAvailable() throws {
        self.mock.response = .success(Stubbed.successStubbedData)
        
        let service = UsersListWebService(baseURL: URL(string: "abc.com")!, networkSession: self.mock)
        let expectation = self.expectation(description: "Expect success")
        
        service.fetchUsersList { response in
            expectation.fulfill()
            
            do {
                let successResponse = try response.get()
                XCTAssertNotNil(successResponse)
                XCTAssertEqual(successResponse.count, 1)
                XCTAssertEqual(successResponse.first?.id, 1)
            } catch {
                XCTFail()
            }
            
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testFailureResponse() {
        self.mock.response = .failure(NetworkErrors.ResponseError.noDataAvailable)
        
        let service = UsersListWebService(baseURL: URL(string: "abc.com")!, networkSession: self.mock)
        let expectation = self.expectation(description: "Expect success")
        service.fetchUsersList { response in
            expectation.fulfill()
            
            let failureResponse = try? response.get()
            XCTAssertNil(failureResponse)
            
            let errorResponse = response.mapError { _ in NetworkErrors.ResponseError.noDataAvailable }
            if case let Result.failure(error) = errorResponse {
                XCTAssertEqual(NetworkErrors.ResponseError.noDataAvailable.errorDescription, error.errorDescription)
            }
            
        }
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testResponseParseFailError() {
        self.mock.response = .success(Stubbed.parseFailStubbedData)
        
        let service = UsersListWebService(baseURL: URL(string: "abc.com")!, networkSession: self.mock)
        let expectation = self.expectation(description: "Expect success")
        service.fetchUsersList { response in
            expectation.fulfill()
            
            let failureResponse = try? response.get()
            XCTAssertNil(failureResponse)
            
            let errorResponse = response.mapError { error in NetworkErrors.ParsingError.unableToParse }
            if case let Result.failure(error) = errorResponse {
                XCTAssertEqual(NetworkErrors.ParsingError.unableToParse.errorDescription, error.errorDescription)
            }
        }
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testValidRequest() {
        let service = UsersListWebService(baseURL: URL(string: "abc.com")!, networkSession: self.mock)
        let expectation = self.expectation(description: "Expect success")
        service.fetchUsersList { response in
            expectation.fulfill()
        }
        
        guard let receivedRequest = self.mock.request as? UsersListRequest else {
            XCTFail("Invalid request received expected was UsersListRequest")
            return
        }
        
        XCTAssertEqual(receivedRequest.url.absoluteString, "abc.com")
        XCTAssertEqual(try receivedRequest.expressAsURLRequest().url?.absoluteString, URLRequest(url: URL(string: "https://abc.com/users")!).url?.absoluteString)
        
        self.wait(for: [expectation], timeout: 1)
    }
}
