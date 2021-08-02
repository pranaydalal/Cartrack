//
//  UserDetailsViewModelTests.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 02/08/21.
//

import XCTest
@testable import Cartrack

class UserDetailsViewModelTests: XCTestCase {

    func testUserDetails() {
        guard let user = try? JSONDecoder().decode(User.self, from: Stubbed.successUserStubbedData) else {
            XCTFail()
            return
        }
        let viewModel = UserDetailsViewModel(user: user)
        let expectedAddress = [user.address.street ,user.address.suite, user.address.city, user.address.zipcode].joined(separator: ",\n")
        XCTAssertEqual(viewModel.address, expectedAddress)
        
        XCTAssertNotNil(viewModel.location)
        
        XCTAssertEqual(viewModel.username, user.name)
        
        XCTAssertEqual(viewModel.email, user.email)
        
        XCTAssertEqual(viewModel.phone, user.phone)
        
        XCTAssertEqual(viewModel.website, user.website)
        
        XCTAssertEqual(viewModel.organisation, user.company.name)
    }
    
    func testUserLocationNil() {
        guard let user = try? JSONDecoder().decode(User.self, from: Stubbed.successUserStubbedDataWithNonNumberLatLng) else {
            XCTFail()
            return
        }
        let viewModel = UserDetailsViewModel(user: user)
        
        XCTAssertNil(viewModel.location)
    }
}
