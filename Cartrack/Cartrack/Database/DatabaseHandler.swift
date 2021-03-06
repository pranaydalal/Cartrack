//
//  DatabaseHandler.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 29/07/21.
//

import Foundation
import SQLite3

protocol UserAccountService {
    /**
     To check if the user is authenticted with the credentials provided
     
     - parameters:
        - username: User name of the user
        - password: Password of the user
     */
    func authenticateUser(withUserName username: String, andPassword password: String) -> Bool
    
    /**
     To register the user with the provided credentials
     
     - parameters:
        - username: User name of the user
        - password: Password of the user
        - country: Country of the user
     */
    func registerUser(withUserName username: String, andPassword password: String, andCountry country: String) -> Bool
}

class UserDatabaseHandler: UserAccountService {

    // MARK: - Constants
    
    static private let databaseName = "CarTrackDB"
    static private let databaseExtension = "sqlite"
    
    static private let userTable = "ctappusers"
    static private let userNameColumn = "username"
    static private let passwordColumn = "password"
    static private let countryColumn = "country"
    
    // MARK: - Private properties
    
    private var opaquePointer: OpaquePointer!
    private let documentUrl = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    private static let sharedHandler: UserDatabaseHandler = {
        return UserDatabaseHandler()
    } ()
    
    // MARK: - Initializers
    
    private init() {
        self.prepareDatafile()
        opaquePointer = self.establishConnectionToDatabase()
        
        // hardcoding user credentials as registration screen is in future scope
        self.registerUser(withUserName: "ABC123", andPassword: "abc@123", andCountry: "Portugal")
    }
    
    // MARK: - Private methods
    
    private func prepareDatafile() {
        let selfType = type(of: self)
        let databaseFileURL = URL(fileURLWithPath: documentUrl).appendingPathComponent("\(selfType.databaseName).\(selfType.databaseExtension)")
        let filemanager = FileManager.default

        if !FileManager.default.fileExists(atPath: databaseFileURL.path) {
            do {
                if let localUrl = Bundle.main.url(forResource: selfType.databaseName, withExtension: selfType.databaseExtension) {
                    try filemanager.copyItem(atPath: (localUrl.path), toPath: databaseFileURL.path)
                }
            } catch { }
        }
    }

    private func establishConnectionToDatabase() -> OpaquePointer? {
        let selfType = type(of: self)
        let databaseFileURL = URL(fileURLWithPath: self.documentUrl).appendingPathComponent("\(selfType.databaseName).\(selfType.databaseExtension)")
        var database: OpaquePointer?
        
        if sqlite3_open(databaseFileURL.path, &database) == SQLITE_OK { return database }
        return nil
    }
    
    // MARK: - Public methods
    
    class func shared() -> UserDatabaseHandler {
        return sharedHandler
    }

    
    // MARK: - User account service
    
    func authenticateUser(withUserName username: String, andPassword password: String) -> Bool {
        var opaqueQuery: OpaquePointer?
        let selfType = type(of: self)
        let query = "select * from \(selfType.userTable) where \(selfType.userNameColumn) = '\(username)' and \(selfType.passwordColumn) = '\(password)'"
        
        if sqlite3_prepare_v2(opaquePointer, query, -1, &opaqueQuery, nil) == SQLITE_OK {
            if  sqlite3_step(opaqueQuery) == SQLITE_ROW {
                sqlite3_finalize(opaqueQuery)
                return true
            }
        }
        
        sqlite3_finalize(opaqueQuery)
        return false
    }
    
    func registerUser(withUserName username: String, andPassword password: String, andCountry country: String) -> Bool {
        let selfType = type(of: self)
        let query = "insert into \(selfType.userTable)(\(selfType.userNameColumn),\(selfType.passwordColumn),\(selfType.countryColumn)) values ('\(username)' , '\(password)' , '\(country)')"
        var opaqueQuery: OpaquePointer?
        
        if sqlite3_prepare_v2(opaquePointer, query, -1, &opaqueQuery, nil) == SQLITE_OK {
            if sqlite3_step(opaqueQuery) == SQLITE_DONE {
                return true
            }
        }

        sqlite3_finalize(opaqueQuery)
        return false
    }
}
