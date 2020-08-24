//
//  SeriesAPIWrapper.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct SeriesAPIWrapper {

    private let seriesAPIService: SeriesAPIService
    private let seriesDecoderService: SeriesDecoderService

    init(
        seriesAPIService: SeriesAPIService,
        seriesDecoderService: SeriesDecoderService
    ) {
        self.seriesAPIService = seriesAPIService
        self.seriesDecoderService = seriesDecoderService
    }

    func getAllSeries(
        forCharacters characters: [String],
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    ) {
        seriesAPIService.getAllSeries(forCharacters: characters.joined(separator: ",")) { result in
            switch result {
            case let .success(data):
                let decodedResult = seriesDecoderService.decodeAllSeries(from: data)
                complete(decodedResult.map({ $0.map({ Series(from: $0) }) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
