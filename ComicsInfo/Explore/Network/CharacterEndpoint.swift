//
//  CharacterEndpoint.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2021.
//

import Foundation

enum CharacterEndpoint: EndpointType {
    
    case getAllCharacters(afterID: String?, fields: Set<String>?, limit: Int)
    case getCharacter(withID: String)
    
    var baseURL: URL {
        Environment.rootURL
    }
    
    var path: String {
        switch self {
        case .getAllCharacters:
            return "/characters"
        case let .getCharacter(characterID):
            return "/characters/\(characterID)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllCharacters, .getCharacter:
            return .GET
        }
    }
    
    var body: Data? {
        nil
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case let .getAllCharacters(afterID, fields, limit):
            var parameters = ["limit": "\(limit)"]
            
            if let afterID = afterID {
                parameters["afterID"] = afterID
            }
            
            if let fields = fields {
                parameters["fields"] = fields.joined(separator: ",")
            }
            
            return parameters
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
        nil
    }
    
}

