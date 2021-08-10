//
//  SeriesEndpoint.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2021.
//

import Foundation

enum SeriesEndpoint: EndpointType {
    
    case getAllSeries
    case getSeries(withID: String)
    
    var baseURL: URL {
        Environment.rootURL
    }
    
    var path: String {
        switch self {
        case .getAllSeries:
            return "/series"
        case let .getSeries(seriesID):
            return "/series/\(seriesID)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllSeries, .getSeries:
            return .GET
        }
    }
    
    var body: Data? {
        nil
    }
    
    var queryParameters: [String: String]? {
        nil
    }
    
    var headers: [String : String]? {
        nil
    }
    
}

