//
//  String+Regex.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 02/08/21.
//

import Foundation

extension String {
    
    /**
     Check if regex mathes the string
     
     - parameter regexPattern: Regex to match
     */
    func doesMatchRegex(_ regexPattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: .caseInsensitive) else {
            return false
        }
        return regex.matches(in: self, options: [], range: NSMakeRange(0, self.count)).count > 0
    }
}
