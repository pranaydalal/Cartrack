//
//  UsersListWebService.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 28/07/21.
//

import Foundation

protocol WebService {
    /**
     Initializes with provided URL and session
     
     - parameters:
        - baseURL: Base URL
        - networkSession: Network session to connect to server
     */
    init(baseURL: URL, networkSession: NetworkSession)

    /**
     To fetch data from server
     
     - parameter completion: Callback to be invoked at the end of call
     */
    func fetchUsersList(_ completion: @escaping ((Result<[User], Error>) -> Void))
}

struct UsersListWebService: WebService {
    private let baseURL: URL
    private let networkSession: NetworkSession
    
    init(baseURL: URL, networkSession: NetworkSession = URLSession(configuration: .ephemeral)) {
        self.baseURL = baseURL
        self.networkSession = networkSession
    }
    
    func fetchUsersList(_ completion: @escaping ((Result<[User], Error>) -> Void)) {
        let usersListRequest = UsersListRequest(url: self.baseURL)
        usersListRequest.execute(onNetwork: self.networkSession, then: completion)
    }
}
