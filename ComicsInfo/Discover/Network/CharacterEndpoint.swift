//
//  CharacterEndpoint.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2021.
//

import Foundation

enum CharacterEndpoint: EndpointType {
    
    case getAllCharacters(fields: Set<String>)
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
        case let .getAllCharacters(fields):
            return ["fields": fields.joined(separator: ",")]
        case .getCharacter:
            return nil
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
}

