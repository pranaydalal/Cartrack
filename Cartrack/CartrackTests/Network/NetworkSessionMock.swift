//
//  NetworkSessionMock.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 28/07/21.
//

import Foundation

@testable import Cartrack

enum ResponeType {
    case success(Data)
    case failure(Error)
}

class NetworkSessionMock: NetworkSession {
    
    enum NetworkSessionMockError: Error {
        case responseIsNotSet
    }
    
    var request: URLRequestConvertible?
    var url: URL?
    var response: ResponeType = .success(Data())
    
    func call(_ request: URLRequestConvertible, then completionHandler: @escaping ((Result<Data, Error>) -> Void)) {
        
        do {
            self.request = request
            self.url = try request.expressAsURLRequest().url
            switch self.response {
            case let .success(data):
                completionHandler(.success(data))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        } catch {
            completionHandler(.failure(error))
        }
    }
}
