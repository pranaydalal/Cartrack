//
//  UserTableViewCell.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 31/07/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    static let reusableIdentifier = "UserTableViewCell"
    
    @IBOutlet weak var wrapperView: UIView! {
        didSet {
            self.wrapperView.backgroundColor = UIColor(red: 228.0 / 255.0, green: 228.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
