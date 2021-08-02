//
//  CountryPickerViewController.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 30/07/21.
//

import UIKit

protocol CountryPickerViewControllerDelegate {
    /**
     To notify the newly selcected country
     
     - parameters:
        - countryPickerView: Instance of PickerView of which this notification is
        - country: The newly selected country
     */
    func countryPickerView(_ countryPickerView: CountryPickerViewController, didSelectCountry country: String)
}

class CountryPickerViewController : UIViewController {

    // MARK: - Private properties
    
    private var countryPickerViewModel = CountryPickerViewModel()
    
    private lazy var countryPickerView : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    // MARK: - Public properties
    
    var delegate: CountryPickerViewControllerDelegate?
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.initialize()
        self.bindViewModel()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        self.view.addSubview(self.countryPickerView)
        
        let constraints = [
            self.countryPickerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.countryPickerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.countryPickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func initialize() {
        if let selectedRow = self.countryPickerViewModel.selectedRow() {
            self.countryPickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        }
    }
    
    private func bindViewModel() {
        self.countryPickerViewModel.didUpdateCountry = { country in
            self.delegate?.countryPickerView(self, didSelectCountry: country)
        }
        self.countryPickerViewModel.didDismiss = {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Public methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.countryPickerViewModel.dismiss()
    }
    
    /**
     To set the country as selected
     
     - parameter country: Used to check the string in list and set if available
     */
    func selectCountryIfAvailable(country: String) {
        self.countryPickerViewModel.country = country
        
        if let selectedRow = self.countryPickerViewModel.selectedRow() {
            self.countryPickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        }
    }
}

// MARK: - Picker view delegate

extension CountryPickerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countryPickerViewModel.numberOfRows()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.countryPickerViewModel.titleForRow(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.countryPickerViewModel.select(row: row)
    }
}
