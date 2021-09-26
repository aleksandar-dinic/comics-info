//
//  EndpointType.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2021.
//

import Foundation

protocol EndpointType {
    
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var body: Data? { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }
    
}
