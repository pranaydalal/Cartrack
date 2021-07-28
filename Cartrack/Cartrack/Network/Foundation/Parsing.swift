//
//  Parsing.swift
//  Cartrack
//
//  Created by PRANAY DALAL on 27/07/21.
//

import Foundation

func parse<T: Decodable>(toType: T.Type, data: Data) throws -> T {
    return try JSONDecoder().decode(T.self, from: data)
}
