//
//  UsersListViewController.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 31/07/21.
//

import UIKit

class UsersListViewController: UITableViewController {
    
    private let usersListViewModel = UsersListViewModel(with: UsersListWebService(baseURL: URL(string: "jsonplaceholder.typicode.com")!))
    private var users: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.bindViewModel()
        
        self.usersListViewModel.fetchUsers()
    }

    private func setupUI() {
        self.title = "Users"
        
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: UserTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: UserTableViewCell.reusableIdentifier)
        self.tableView.separatorStyle = .none
    }
    
    func bindViewModel() {
        self.usersListViewModel.didShowError = { [weak self] error in
            guard let _self = self else { return }
            
            _self.launchLoadingFailed(title: error, message: nil)
        }
        
        self.usersListViewModel.didstartLoading = { [weak self] in
            guard let _self = self else { return }
            
            //show loader
        }
        
        self.usersListViewModel.didEndLoading = { [weak self] in
            guard let _self = self else { return }
            
            //hide loader
        }
        
        self.usersListViewModel.didReloadUsersListData = { [weak self] users in
            guard let _self = self else { return }
            
            _self.users = users
            self?.tableView.reloadData()
        }
        
        self.usersListViewModel.didUserSelected = { [weak self] user in
            guard let _self = self else { return }
            
            // Navigate to user details screens
        }
    }
    
    private func launchLoadingFailed(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Table view data source

extension UsersListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reusableIdentifier, for: indexPath)
        cell.selectionStyle = .none
        
        if let user = self.users?[indexPath.row], let userTableViewCell = cell as? UserTableViewCell {
            userTableViewCell.user = user
        }
        
        if indexPath.row == (self.users?.count ?? 0) - 1 {
            self.usersListViewModel.fetchUsers()
        }
        
        return cell
    }
}

// MARK: - Table view delegate

extension UsersListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.usersListViewModel.userSelected(at: indexPath.row)
    }
}
