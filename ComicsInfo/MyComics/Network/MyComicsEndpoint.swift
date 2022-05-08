//
//  MyComicsEndpoint.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/1/22.
//

import Foundation

enum MyComicsEndpoint: EndpointType {
    
    case createMyCharacter(_ myCharacter: Data, token: String)
    case getAllMyCharacters(token: String)
    case getMyCharacter(withID: String, token: String)
    case updateMyCharacter(_ myCharacter: Data, withID: String, token: String)
    case deleteMyCharacter(withID: String, token: String)
    
    case createMyComic(_ myComic: Data, seriesID: String, token: String)
    case getAllMyComics(seriesID: String, token: String)
    case getMyComic(withID: String, seriesID: String, token: String)
    case updateMyComic(_ myComic: Data, withID: String, seriesID: String, token: String)
    case deleteMyComic(withID: String, seriesID: String, token: String)
    
    var baseURL: URL {
        Environment.rootURL
    }
    
    var path: String {
        switch self {
        case .createMyCharacter, .getAllMyCharacters:
            return "/my-characters"
        case let .getMyCharacter(characterID, _),
            let .updateMyCharacter(_, characterID, _),
            let .deleteMyCharacter(characterID, _):
            return "/my-characters/\(characterID)"
            
        case .createMyComic, .getAllMyComics:
            return "/my-comics"
        case let .getMyComic(comicID, _, _ ),
            let .updateMyComic(_, comicID, _, _),
            let .deleteMyComic(comicID, _, _):
            return "/my-comics/\(comicID)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .createMyCharacter, .createMyComic:
            return .POST
        case .getAllMyCharacters,
                .getMyCharacter,
                .getAllMyComics,
                .getMyComic:
            return .GET
        case .updateMyCharacter, .updateMyComic:
            return .PUT
        case .deleteMyCharacter, .deleteMyComic:
            return .DELETE
        }
    }
    
    var body: Data? {
        switch self {
        case let .createMyCharacter(myCharacter, _),
            let .updateMyCharacter(myCharacter, _, _):
            return myCharacter
        case let .createMyComic(myComic, _, _),
            let .updateMyComic(myComic, _, _, _):
            return myComic
        default:
            return nil
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case let .createMyComic(_, seriesID, _),
            let .getAllMyComics(seriesID, _),
            let .getMyComic(_, seriesID, _),
            let .updateMyComic(_, _, seriesID, _),
            let .deleteMyComic(_, seriesID, _):
            return ["seriesID": seriesID]
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case let .createMyCharacter(_, token),
            let .getAllMyCharacters(token),
            let .getMyCharacter(_, token),
            let .updateMyCharacter(_, _, token),
            let .deleteMyCharacter(_, token),
            let .createMyComic(_, _, token),
            let .getAllMyComics(_, token),
            let .getMyComic(_, _, token),
            let .updateMyComic(_, _, _, token),
            let .deleteMyComic(_, _, token):
            return ["Authorization": token]
        }
    }
    
}
