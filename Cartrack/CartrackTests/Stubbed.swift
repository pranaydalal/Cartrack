//
//  Stubbed.swift
//  CartrackTests
//
//  Created by PRANAY DALAL on 02/08/21.
//

import Foundation

struct Stubbed {
    static let successUserStubbedData = Data("""
                    {
                        \"id\": 1,
                        \"name\": \"Leanne Graham\",
                        \"username\": \"Bret\",
                        \"email\": \"Sincere@april.biz\",
                        \"address\": {
                          \"street\": \"Kulas Light\",
                          \"suite\": \"Apt. 556\",
                          \"city\": \"Gwenborough\",
                          \"zipcode\": \"92998-3874\",
                          \"geo\": {
                            \"lat\": \"-37.3159\",
                            \"lng\": \"81.1496\"
                          }
                        },
                        \"phone\": \"1-770-736-8031 x56442\",
                        \"website\": \"hildegard.org\",
                        \"company\": {
                          \"name\": \"Romaguera-Crona\",
                          \"catchPhrase\": \"Multi-layered client-server neural-net\",
                          \"bs\": \"harness real-time e-markets\"
                        }
                    }
                """.utf8)
    
    static let successStubbedData = Data("""
                [
                    {
                        \"id\": 1,
                        \"name\": \"Leanne Graham\",
                        \"username\": \"Bret\",
                        \"email\": \"Sincere@april.biz\",
                        \"address\": {
                          \"street\": \"Kulas Light\",
                          \"suite\": \"Apt. 556\",
                          \"city\": \"Gwenborough\",
                          \"zipcode\": \"92998-3874\",
                          \"geo\": {
                            \"lat\": \"-37.3159\",
                            \"lng\": \"81.1496\"
                          }
                        },
                        \"phone\": \"1-770-736-8031 x56442\",
                        \"website\": \"hildegard.org\",
                        \"company\": {
                          \"name\": \"Romaguera-Crona\",
                          \"catchPhrase\": \"Multi-layered client-server neural-net\",
                          \"bs\": \"harness real-time e-markets\"
                        }
                    }
                ]
                """.utf8)
    
    static let parseFailStubbedData = Data("""
                [
                    {
                        \"id\": 1,
                        \"name\": \"Leanne Graham\",
                        \"username\": \"Bret\",
                        \"email\": \"Sincere@april.biz\"
                    }
                ]
                """.utf8)
    
    static let successUserStubbedDataWithNonNumberLatLng = Data("""
                    {
                        \"id\": 1,
                        \"name\": \"Leanne Graham\",
                        \"username\": \"Bret\",
                        \"email\": \"Sincere@april.biz\",
                        \"address\": {
                          \"street\": \"Kulas Light\",
                          \"suite\": \"Apt. 556\",
                          \"city\": \"Gwenborough\",
                          \"zipcode\": \"92998-3874\",
                          \"geo\": {
                            \"lat\": \"Incorrect\",
                            \"lng\": \"Incorrect\"
                          }
                        },
                        \"phone\": \"1-770-736-8031 x56442\",
                        \"website\": \"hildegard.org\",
                        \"company\": {
                          \"name\": \"Romaguera-Crona\",
                          \"catchPhrase\": \"Multi-layered client-server neural-net\",
                          \"bs\": \"harness real-time e-markets\"
                        }
                    }
                """.utf8)
}
