//
//  UsersListRequest.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 28/07/21.
//

import Foundation

struct UsersListRequest {
    let url: URL
    
    /**
     Initializes `UsersListRequest` with URL
     
     - parameters:
        - url: Base URL for users  list
     */
    init(url: URL) {
        self.url = url
    }
}

extension UsersListRequest: DataRequest, ParameteredRequest {
    typealias Response = [User]
    
    var endPoint: String {
        return "/users"
    }
    
    func expressAsURLRequest() throws -> URLRequest {
        try self.buildURL()
    }
    
    func buildURL() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.path = self.endPoint
        components.host = self.url.absoluteString
        
        guard components.host != nil,
              let localURL = components.url else {
            let errorMessage = components.queryItems?.map { String(describing: $0) }
                .joined(separator: ", ") ?? ""
            throw BuilderError.unableBuildURL(message: "query item \(errorMessage)")
        }
        
        return URLRequest(url: localURL,
                          cachePolicy: URLRequest.CachePolicy.reloadRevalidatingCacheData,
                          timeoutInterval: 30)
    }
}
