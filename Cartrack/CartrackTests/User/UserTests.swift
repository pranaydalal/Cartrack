//
//  UserTests.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 28/07/21.
//

import XCTest

@testable import Cartrack

class UserTests: XCTestCase {

    private var userDetails: User?
    
    override func setUpWithError() throws {
        do {
            self.userDetails = try JSONDecoder().decode(User.self, from: Stubbed.successUserStubbedData)
            
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
