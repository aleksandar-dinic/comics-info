//
//  NetworkResponse.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2021.
//

import Foundation

struct NetworkResponse {
    
    let statusCode: HTTPStatusCode
    let data: Data?
    
    var error: NetworkError {
        guard let data = data, let response = try? JSONDecoder().decode(Response.self, from: data) else {
            return NetworkError(for: statusCode, message: nil)
        }
        
        return NetworkError(for: statusCode, message: response.message)
    }
    
}

extension NetworkResponse {
    
    init(statusCode: Int, data: Data?) {
        self.statusCode = HTTPStatusCode(rawValue: statusCode) ?? .undefined
        self.data = data
    }
    
}
