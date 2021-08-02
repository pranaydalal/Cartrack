//
//  UserTableViewCell.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 31/07/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    /// Reusable Identifier to load the Cell from nib
    static let reusableIdentifier = "UserTableViewCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var wrapperView: UIView! {
        didSet {
            self.wrapperView.layer.cornerRadius = 5.0
            self.wrapperView.layer.borderColor = UIColor.lightGray.cgColor
            self.wrapperView.layer.borderWidth = 0.2
            self.wrapperView.layer.shadowColor = UIColor.black.cgColor
            self.wrapperView.layer.shadowOpacity = 0.5
            self.wrapperView.layer.shadowOffset = CGSize(width:1, height: 1)
            self.wrapperView.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var profilePictureImageView: UIImageView! {
        didSet {
            self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.height/2
        }
    }

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - Public properties
    
    /// To display user details
    var user: User? {
        didSet {
            self.userNameLabel.text = self.user?.name
            self.emailLabel.text = self.user?.email
        }
    }
}
