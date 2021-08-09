//
//  NetworkResponseHandler.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2021.
//

import Foundation

protocol NetworkResponseHandler {
    
    func handle(_ result: Result<NetworkResponse, Error>, successStatuses: Set<HTTPStatusCode>) -> Result<Data, Error>
    
}

extension NetworkResponseHandler {
    
    func handle(_ result: Result<NetworkResponse, Error>, successStatuses: Set<HTTPStatusCode>) -> Result<Data, Error> {
        switch result {
        case let .success(networkResponse):
            guard successStatuses.contains(networkResponse.statusCode) else {
                return .failure(networkResponse.error)
            }

            guard let data = networkResponse.data else {
                return .failure(NetworkError.missingData)
            }
            return .success(data)
            
        case let .failure(error):
            return .failure(error)
        }
    }
    
}
