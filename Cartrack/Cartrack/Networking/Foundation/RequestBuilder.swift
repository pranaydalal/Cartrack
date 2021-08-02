//
//  RequestBuilder.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 27/07/21.
//

import Foundation

enum BuilderError: Error {
    case apiKeyMissing
    case unableToResolveURL(URL)
    case unableBuildURL(message: String)
}

protocol RequestBuilder {
    /**
     Build and return actual Request
     
     - parameter url: URL to create request
     */
    func buildURLRequest(with url: URL) -> URLRequest
    
    /**
     Build and return actual Request with url and parameters
     
     - parameters:
        - url: URL to create request
        - parameters: Parameters to be passed along with the request
     */
    func buildURLRequest(withURL url: URL, andParameters parameters: [String: String]) throws -> URLRequest
}

struct NetworkRequestBuilder: RequestBuilder {
    
    func buildURLRequest(with url: URL) -> URLRequest {
        return URLRequest(url: url,
                          cachePolicy: URLRequest.CachePolicy.reloadRevalidatingCacheData,
                          timeoutInterval: 30)
    }
    
    func buildURLRequest(withURL url: URL, andParameters parameters: [String: String]) throws -> URLRequest {
        
        guard var components = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false) else {
                                                throw BuilderError.unableToResolveURL(url)
        }
        
        var queryItems = [URLQueryItem]()
        for key in parameters.keys.sorted() {
            guard let param = parameters[key] else { continue }
            queryItems.append(URLQueryItem(name: key, value: param))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            let errorMessage = components.queryItems?.map { String(describing: $0) }.joined(separator: ", ") ?? ""
            
            throw BuilderError.unableBuildURL(message: "query item \(errorMessage)")
        }
        
        
        return URLRequest(url: url,
                          cachePolicy: URLRequest.CachePolicy.reloadRevalidatingCacheData,
                          timeoutInterval: 30)
    }
}
