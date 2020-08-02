//
//  SeriesAPIWrapper.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import Foundation

public struct SeriesAPIWrapper: ResultDecoder {

    private let seriesAPIService: SeriesAPIService

    init(seriesAPIService: SeriesAPIService) {
        self.seriesAPIService = seriesAPIService
    }

    func getAllSeries(
        forCharacterID characterID: String,
        onComplete complete: @escaping (Result<[Domain.Series], Error>) -> Void
    ) {
        seriesAPIService.getAllSeries(forCharacterID: characterID) { result in
            complete(self.decode(result))
        }
    }

}
