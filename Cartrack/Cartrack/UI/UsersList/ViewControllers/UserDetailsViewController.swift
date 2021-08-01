//
//  UserDetailsViewController.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 01/08/21.
//

import UIKit

class UserDetailsViewController: UIViewController {
    static let storyboardIdentifier = "UserDetailsViewController"
    
    private let userDetailsViewModel = UserDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "User details"
    }
}
