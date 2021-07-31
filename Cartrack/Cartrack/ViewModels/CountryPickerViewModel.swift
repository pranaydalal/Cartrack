//
//  CountryPickerViewModel.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 30/07/21.
//

import Foundation

class CountryPickerViewModel {
    
    var didUpdateCountry:((String)->())?
    var didDismiss:(()->())?
    
    var country : String = "" {
        didSet {
            self.didUpdateCountry?(country)
        }
    }
    
    private var countrySelection : [String] {
        return Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
    }
    
    func selectedRow() -> Int? {
        return self.countrySelection.firstIndex(of: country)
    }
    
    func numberOfRows() -> Int {
        return self.countrySelection.count
    }
    
    func titleForRow(row: Int) -> String? {
        guard row >= 0 && row < self.countrySelection.count else { return nil }
        return self.countrySelection[row]
    }
    
    func select(row: Int) {
        guard let title = self.titleForRow(row: row) else { return }
        self.country = title
    }
    
    func dismiss() {
        self.didDismiss?()
    }
}
