//
//  CountryPickerViewModelTests.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 02/08/21.
//

import XCTest
@testable import Cartrack

class CountryPickerViewModelTests: XCTestCase {
    
    var viewModel : CountryPickerViewModel!
    
    override func setUpWithError() throws {
        self.viewModel = CountryPickerViewModel()
        self.viewModel.country = "Singapore"
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
    }

    func testCountryPicker() {
        XCTAssert(self.viewModel.numberOfRows() > 0)
        XCTAssertNil(self.viewModel.titleForRow(row: -1))
        XCTAssertNil(self.viewModel.titleForRow(row: 10000))
        XCTAssertEqual(self.viewModel.country, "Singapore")
        XCTAssertNotNil(self.viewModel.selectedRow())
        
        let changeExpectation = expectation(description: "change")
        self.viewModel.didUpdateCountry = { country in
            XCTAssertEqual(country, "Philippines")
            changeExpectation.fulfill()
        }
        self.viewModel.country = "Philippines"
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
    func testSelectValid() {
        self.viewModel.select(row: 1)
        XCTAssert(self.viewModel.selectedRow() == 1)
    }
    
    func testSelectInvalidRow() {
        self.viewModel.select(row: 10000)
        XCTAssert(self.viewModel.selectedRow() != 10000)
    }
    
    func testDismiss() {
        let dismissExpectation = expectation(description: "dismiss")
        self.viewModel.didDismiss = {
            dismissExpectation.fulfill()
        }
        self.viewModel.dismiss()
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
