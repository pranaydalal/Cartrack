//
//  UserDetailsViewController.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 01/08/21.
//

import UIKit
import MapKit

class UserDetailsViewController: UIViewController {
    static let storyboardIdentifier = "UserDetailsViewController"
    
    private var userDetailsViewModel: UserDetailsViewModel!
    
    var user : User! {
        didSet {
            self.userDetailsViewModel = UserDetailsViewModel(user: self.user)
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var organisationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            self.mapView.layer.cornerRadius = 5.0
            self.mapView.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "User details"
        
        self.userNameLabel.text = self.userDetailsViewModel.username
        self.addressLabel.text = self.userDetailsViewModel.address
        self.phoneNumberLabel.text = self.userDetailsViewModel.phone
        self.emailLabel.text = self.userDetailsViewModel.email
        self.websiteLabel.text = self.userDetailsViewModel.website
        self.organisationLabel.text = self.userDetailsViewModel.organisation
        
        self.setupMapView()
    }
    
    private func setupMapView() {
        guard let coordinate = self.userDetailsViewModel.location?.coordinate else {
            return
        }
        
        // Pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = self.userDetailsViewModel.address
        self.mapView.addAnnotation(annotation)
        
        // Camera
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: false)
    }
}
