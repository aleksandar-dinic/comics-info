//
//  ComicDecoderProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import protocol CIData.ComicDecoderService
import Foundation

public struct ComicDecoderProvider: CIData.ComicDecoderService {

    public func decodeAllComics(from data: Data) -> Result<[Domain.Comic], Error> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        do {
            let characters = try decoder.decode([Domain.Comic].self, from: data)
            return .success(characters)

        } catch {
            return .failure(error)
        }
    }

}
