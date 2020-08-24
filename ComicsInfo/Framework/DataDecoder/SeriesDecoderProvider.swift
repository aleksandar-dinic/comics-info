//
//  SeriesDecoderProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import protocol CIData.SeriesDecoderService
import Foundation

public struct SeriesDecoderProvider: CIData.SeriesDecoderService {

    public func decodeAllSeries(from data: Data) -> Result<[Domain.Series], Error> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        do {
            let characters = try decoder.decode([Domain.Series].self, from: data)
            return .success(characters)

        } catch {
            return .failure(error)
        }
    }

}
