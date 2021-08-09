//
//  NetworkError.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    case undefined(_ message: String?)
    
    case missingData
    case invalidResponse
    
    case noContent(_ message: String?)
    case notModified(_ message: String?)
    case badRequest(_ message: String?)
    case unauthorized(_ message: String?)
    case forbidden(_ message: String?)
    case notFound(_ message: String?)
    case methodNotAllowed(_ message: String?)
    case notAcceptable(_ message: String?)
    case conflict(_ message: String?)
    case internalServerError
    
}

extension NetworkError {
    
    init(for statusCode: HTTPStatusCode, message: String?) {
        switch statusCode {
        case .noContent:
            self = .noContent(message)
        case .notModified:
            self = .notModified(message)
        case .badRequest:
            self = .badRequest(message)
        case .unauthorized:
            self = .unauthorized(message)
        case .forbidden:
            self = .forbidden(message)
        case .notFound:
            self = .notFound(message)
        case .methodNotAllowed:
            self = .methodNotAllowed(message)
        case .notAcceptable:
            self = .notAcceptable(message)
        case .conflict:
            self = .conflict(message)
        case .internalServerError:
            self = .internalServerError
        default:
            self = .undefined(message)
        
        }
    }
    
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case let .undefined(message),
             let .noContent(message),
             let .notModified(message),
             let .badRequest(message),
             let .unauthorized(message),
             let .forbidden(message),
             let .notFound(message),
             let .methodNotAllowed(message),
             let .notAcceptable(message),
             let .conflict(message):
            return message
        default:
            return "somethingWentWrongLocalized"
        }
    }
    
}
