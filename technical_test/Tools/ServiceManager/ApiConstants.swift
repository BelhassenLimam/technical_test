//
//  ApiConstants.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation
import Combine

struct ApiConstants {
    static let BASE_URL = "https://www.thesportsdb.com/api/v1/json"
    static let ApiKey = "/50130162"
    static let AllLeagues = "/all_leagues.php"
}
enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
enum APIError: Error {
    case invalidResponse
    case invalidData
}
