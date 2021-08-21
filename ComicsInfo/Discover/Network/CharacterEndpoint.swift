//
//  CharacterEndpoint.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2021.
//

import Foundation

enum CharacterEndpoint: EndpointType {
    
    case getAllCharacters
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
        return nil
    }
    
    var headers: [String : String]? {
        nil
    }
    
}

