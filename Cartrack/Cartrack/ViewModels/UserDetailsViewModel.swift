//
//  UserDetailsViewModel.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 01/08/21.
//

import Foundation
import CoreLocation

final class UserDetailsViewModel {
    let user : User
    
    init(user: User) {
        self.user = user
    }
    
    var address : String {
        let addressContents = [user.address.street ,user.address.suite, user.address.city, user.address.zipcode]
            .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        return addressContents.joined(separator: ",\n")
    }
    
    var location : CLLocation? {
        guard let lat = CLLocationDegrees(user.address.geo.lat),
              let lng = CLLocationDegrees(user.address.geo.lng) else {
            return nil
        }
        return CLLocation(latitude: lat, longitude: lng)
    }
    
    var username: String {
        return user.name
    }
    
    var email: String {
        return user.email
    }
    
    var phone: String {
        return user.phone
    }
    
    var website: String {
        return user.website
    }
    
    var organisation: String {
        return user.company.name
    }
}
