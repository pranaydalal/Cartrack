//
//  NetworkSession.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 27/07/21.
//

import Foundation

protocol NetworkSession {
    func call(_ request: URLRequestConvertible, then completionHandler: @escaping ((Result<Data, Error>) -> Void))
}

extension URLSession: NetworkSession {
    
    private typealias DataTaskCompletionCallback = (Data?, URLResponse?, Error?) -> Void
    
    static let acceptableStatusCodes = Set(200...399)
    
    func call(_ request: URLRequestConvertible, then completionHandler: @escaping ((Result<Data, Error>) -> Void)) {
        
        do {
            let urlRequest = try request.expressAsURLRequest()
            let completion: DataTaskCompletionCallback = { data, response, error in
                
                if let requestError = error {
                    completionHandler(.failure(requestError))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, type(of: self).acceptableStatusCodes.contains(httpResponse.statusCode) else {
                    completionHandler(.failure(NetworkErrors.ResponseError.noDataAvailable))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(NetworkErrors.ResponseError.noDataAvailable))
                    return
                }
                
                completionHandler(.success(data))
            }
            
            self.dataTask(with: urlRequest, completionHandler: completion).resume()
        } catch {
            completionHandler(.failure(error))
        }
    }
}
