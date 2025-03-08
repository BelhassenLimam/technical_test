//
//  ApiConstants.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation
import Combine

struct ApiConstants {
    static let BASE_URL = "https://api.pexels.com/v1"
    static let ApiKey = "jTsuYSkJ8gCr8uKHIKX9UuK5XZCDuwQKf7qlvpcaRU27XythiCDvbwPa"
    static let authorization: String = "Authorization"
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
