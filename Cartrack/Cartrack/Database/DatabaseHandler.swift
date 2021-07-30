//
//  DatabaseHandler.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 29/07/21.
//

import Foundation
import SQLite3

protocol UserAccountService {
    func authenticateUser(withUserName username: String, andPassword password: String) -> Bool
    func registerUser(withUserName username: String, andPassword password: String, andCountry country: String) -> Bool
}

class UserDatabaseHandler: UserAccountService {

    static private let databaseName = "CarTrackDB"
    static private let databaseExtension = "sqlite"
    
    static private let userTable = "ctappusers"
    static private let userNameColumn = "username"
    static private let passwordColumn = "password"
    static private let countryColumn = "country"
    
    private var opaquePointer: OpaquePointer!
    private let documentUrl = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    init() {
        self.prepareDatafile()
        opaquePointer = self.establishConnectionToDatabase()
        
        // hardcoding user credentials as registration screen is in future scope
        self.registerUser(withUserName: "ABC", andPassword: "abc@123", andCountry: "Portugal")
    }

    /// Authenticate user
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
        let error = String(cString: sqlite3_errmsg(opaquePointer)!)
        NSLog("Failed to fetch user", error)
        sqlite3_finalize(opaqueQuery)
        return false
    }
    
    /// Register user
    func registerUser(withUserName username: String, andPassword password: String, andCountry country: String) -> Bool {
        let selfType = type(of: self)
        let query = "insert into \(selfType.userTable)(\(selfType.userNameColumn),\(selfType.passwordColumn),\(selfType.countryColumn)) values ('\(username)' , '\(password)' , '\(country)')"
        var opaqueQuery: OpaquePointer?
        
        if sqlite3_prepare_v2(opaquePointer, query, -1, &opaqueQuery, nil) == SQLITE_OK {
            if sqlite3_step(opaqueQuery) == SQLITE_DONE {
                return true
            }
            let error = String(cString: sqlite3_errmsg(opaquePointer)!)
            NSLog("Failed to query table::", error)
        }

        let error = String(cString: sqlite3_errmsg(opaquePointer)!)
        NSLog("Failed to insert into table::", error)
        sqlite3_finalize(opaqueQuery)
        return false
    }

    /// Copy CarTrack database to device
    private func prepareDatafile() {
        let selfType = type(of: self)
        let databaseFileURL = URL(fileURLWithPath: documentUrl).appendingPathComponent("\(selfType.databaseName).\(selfType.databaseExtension)")
        let filemanager = FileManager.default

        if !FileManager.default.fileExists(atPath: databaseFileURL.path) {
            do {
                if let localUrl = Bundle.main.url(forResource: selfType.databaseName, withExtension: selfType.databaseExtension) {
                    try filemanager.copyItem(atPath: (localUrl.path), toPath: databaseFileURL.path)
                    NSLog("Database copied to device::")
                }
                NSLog("Failed to copy database to device ::")
            } catch {
                NSLog("Failed to copy database to device ::")
            }
        }
        NSLog("Database alreayd exists on device")
    }

    /// Establish connection to CarTrack database
    private func establishConnectionToDatabase() -> OpaquePointer? {
        let selfType = type(of: self)
        let databaseFileURL = URL(fileURLWithPath: self.documentUrl).appendingPathComponent("\(selfType.databaseName).\(selfType.databaseExtension)")
        var database: OpaquePointer?
        
        if sqlite3_open(databaseFileURL.path, &database) == SQLITE_OK {
            NSLog("Successfully connected to CarTrackDB", databaseFileURL.path)
            return database
        }
        NSLog("Unable to connect to CarTrackDB")
        return nil
    }
}
