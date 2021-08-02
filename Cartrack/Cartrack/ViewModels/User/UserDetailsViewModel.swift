//
//  UserDetailsViewModel.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 01/08/21.
//

import Foundation
import CoreLocation

final class UserDetailsViewModel {
    
    // MARK: - Private properties
    
    private let user : User
    
    // MARK: - Public properties
    
    /// Address by concatinating address components with ',\n'
    var address : String {
        let addressContents = [user.address.street ,user.address.suite, user.address.city, user.address.zipcode]
            .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        return addressContents.joined(separator: ",\n")
    }
    
    /// Location of user
    var location : CLLocation? {
        guard let lat = CLLocationDegrees(user.address.geo.lat),
              let lng = CLLocationDegrees(user.address.geo.lng) else {
            return nil
        }
        return CLLocation(latitude: lat, longitude: lng)
    }
    
    /// Complete name of user
    var username: String {
        return user.name
    }
    
    /// Email address of user
    var email: String {
        return user.email
    }
    
    /// Phone number of user
    var phone: String {
        return user.phone
    }
    
    /// Website of user
    var website: String {
        return user.website
    }
    
    /// Organisation of user
    var organisation: String {
        return user.company.name
    }
    
    // MARK: Initializers
    
    /**
     To initialize with user
     
     - parameter user: user to be used for getting user details
     */
    init(user: User) {
        self.user = user
    }
}
