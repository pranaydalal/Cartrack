//
//  NetworkConstant.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 01/08/21.
//

import Foundation

/// This Enum can have constants related to network. For now, only base url for Production environment is added, but can have staging and dev environmenr base urls too.
enum NetworkConstant {
    
    // Base Url for Production.
    static let baseURL = URL(string: "jsonplaceholder.typicode.com")!
}

