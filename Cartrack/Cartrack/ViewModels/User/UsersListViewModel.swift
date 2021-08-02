//
//  UsersListViewModel.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 31/07/21.
//

import Foundation

final class UsersListViewModel {
    
    // MARK: Callbacks or observers
    
    /// Callback for showing loader
    var didstartLoading: (() -> Void)?
    
    /// Callback for removing the loader
    var didEndLoading: (() -> Void)?
    
    /// Callback for showing the error message
    var didShowError: ((String) -> Void)?
    
    /// Callback returning selected User
    var didUserSelected: ((User) -> Void)?
    
    /// Callback returning users as datasource
    var didReloadUsersListData: (([User]?) -> Void)?
    
    //MARK: Private properties
    
    private let webservice: WebService?
    
    private var data: [User]?
    private let currentPage = 0
    private let pageSize = 10
    
    private var isDataLoadingInprogress = false
    private var isNextPageAvailable = true
    
    //MARK: Initializers
    
    /**
     To initialize with webservice
     
     - parameter webservice: Webservice to fetch user list
     */
    required init(with webservice: WebService) {
        self.webservice = webservice
    }
    
    //MARK: Public methods
    
    /**
     Select the user at index
     
     - parameter index: Index at which user is to be selected
     */
    func userSelected(at index: Int) {
        guard self.data?.indices.contains(index) ?? false ,let user = self.data?[index] else { return }
        self.didUserSelected?(user)
    }
    
    /// Should be used to fetch the users
    func fetchUsers() {
        
        guard !self.isDataLoadingInprogress, self.isNextPageAvailable else { return }
        
        self.isDataLoadingInprogress = true
        self.didstartLoading?()
        self.webservice?.fetchUsersList({ [weak self] response in
            guard let _self = self else { return }
            DispatchQueue.main.async {
                _self.isDataLoadingInprogress = false
                _self.didEndLoading?()
                switch response {
                case let .success(users):
                    if users.count == 0 { _self.isNextPageAvailable = false }
                    
                    if let users = _self.data {
                        _self.data?.append(contentsOf: users)
                    } else {
                        _self.data = users
                    }
                    
                    _self.data?.append(contentsOf: users)
                    _self.didReloadUsersListData?(_self.data)
                case let .failure(error):
                    _self.didShowError?(error.localizedDescription)
                }
            }
        })
    }
}
