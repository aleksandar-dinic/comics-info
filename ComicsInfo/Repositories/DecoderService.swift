//
//  DecoderService.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol DecoderService {
    
    func decode<T: Codable>(from data: Data) -> Result<T, Error>
    
}

extension DecoderService {
    
    func decode<T: Codable>(from data: Data) -> Result<T, Error> {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
}
