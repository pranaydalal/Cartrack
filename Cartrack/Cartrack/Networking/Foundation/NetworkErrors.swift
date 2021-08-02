//
//  NetworkErrors.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 27/07/21.
//

import Foundation

enum NetworkErrors {
    
    /**
     ResponseError, currently supporting noDataAvailable, can be expanded to add more types of errors.
     
        - noDataAvailable: Returned when server response contains no data or empty data.
     */
    enum ResponseError: Error {
        case noDataAvailable
        
        var errorDescription: String? {
            switch self {
            case .noDataAvailable:
                return "Something went wrong.\n Please try again later"
                
            }
        }
    }
    
    /**
     ParsingError, currently supporting unableToParse, can be expanded to add more types of errors.
     
        - unableToParse: Returned when received server response data could not be parsed.
     */
    enum ParsingError: Error {
        case unableToParse
        
        var errorDescription: String? {
            switch self {
            case .unableToParse:
                return "Something went wrong.\n Please try again later"
            }
        }
    }
}
