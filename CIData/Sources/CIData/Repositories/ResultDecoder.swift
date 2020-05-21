//
//  ResultDecoder.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol ResultDecoder {

    func decode<T: Codable>(_ result: Result<Data, Error>) -> Result<T, Error>

}

extension ResultDecoder {

    func decode<T: Codable>(_ result: Result<Data, Error>) -> Result<T, Error> {
        switch result {
        case let .success(data):

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .millisecondsSince1970

            do {
                let response = try decoder.decode(T.self, from: data)
                return .success(response)

            } catch {
                return .failure(error)
            }

        case let .failure(error):
            return .failure(error)
        }
    }

}
