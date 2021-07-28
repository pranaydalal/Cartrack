//
//  UserTests.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 28/07/21.
//

import XCTest

@testable import Cartrack

class UserTests: XCTestCase {

    static let successStubbedData = Data("""
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
                """.utf8)
    
    private var userDetails: User?
    
    override func setUpWithError() throws {
        do {
            self.userDetails = try JSONDecoder().decode(User.self, from: type(of: self).successStubbedData)
            
        } catch {
            XCTFail()
        }
    }

    override func tearDownWithError() throws {
        self.userDetails = nil
    }

    func testSuccessfulParsing() {
        guard
            let user = self.userDetails
        else {
            XCTFail("user parsing failed")
            return
        }
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.address.geo.lat, "-37.3159")
        XCTAssertEqual(user.address.geo.lng, "81.1496")
    }
}
