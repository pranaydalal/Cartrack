//
//  LoginViewController.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 27/07/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            self.loginButton.layer.cornerRadius = 4
            self.loginButton.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var countryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


}

