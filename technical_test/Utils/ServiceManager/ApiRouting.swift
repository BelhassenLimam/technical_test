//
//  ApiRouting.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var header: [String: String] { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
}

enum ApiRouting: APIEndpoint {
    case getAllStories
    
    var baseURL: URL {
        return URL(string: ApiConstants.BASE_URL)!
    }
    
    var header: [String : String] {
        return [ApiConstants.authorization: ApiConstants.ApiKey]
    }
    
    var path: String {
        switch self {
        case .getAllStories:
            return "/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllStories:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAllStories:
            return ["query": "nature", "per_page":"80"]
        }
    }
}
