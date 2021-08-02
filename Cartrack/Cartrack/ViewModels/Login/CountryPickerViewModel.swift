//
//  CountryPickerViewModel.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 30/07/21.
//

import Foundation

final class CountryPickerViewModel {
    
    // MARK: Callbacks or observers
    
    var didUpdateCountry:((String)->())?
    var didDismiss:(()->())?
    
    //MARK: Private properties
    
    private var countrySelection : [String] {
        return Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
    }
    
    // MARK: Public properties
    
    /// Holds the current selected country
    var country : String = "" {
        didSet {
            self.didUpdateCountry?(country)
        }
    }
    
    //MARK: Public methods
    
    /// To get the Index of current selected country
    func selectedRow() -> Int? {
        return self.countrySelection.firstIndex(of: country)
    }
    
    /// To get the number of countries
    func numberOfRows() -> Int {
        return self.countrySelection.count
    }
    
    /// To get the country at index
    func titleForRow(row: Int) -> String? {
        guard row >= 0 && row < self.countrySelection.count else { return nil }
        return self.countrySelection[row]
    }
    
    /// Select the country at index
    func select(row: Int) {
        guard let title = self.titleForRow(row: row) else { return }
        self.country = title
    }
    
    /// Dismiss the picker
    func dismiss() {
        self.didDismiss?()
    }
}
