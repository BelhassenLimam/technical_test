//
//  ApiRouting.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
}

enum ApiRouting: APIEndpoint {
    case getAllLeagues
    case getAllTeams(leagueName: String)
    
    var baseURL: URL {
        return URL(string: ApiConstants.BASE_URL + ApiConstants.ApiKey)!
    }
    
    var path: String {
        switch self {
        case .getAllLeagues:
            return "/all_leagues.php"
        case .getAllTeams:
            return "/search_all_teams.php"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllLeagues, .getAllTeams:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAllLeagues:
            return nil
        case .getAllTeams(let leagueName):
            return ["l": leagueName]
        }
    }
}
