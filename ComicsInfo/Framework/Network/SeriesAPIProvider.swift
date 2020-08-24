//
//  SeriesAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.SeriesAPIService
import Foundation

public struct SeriesAPIProvider: CIData.SeriesAPIService {

    public func getAllSeries(
        forCharacters characters: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        usleep(useconds_t(Int.random(in: 500_000...2_000_000)))
        guard let data = SeriesMock(forCharacters: characters).data else {
            return complete(.failure(NetworkError.noData))
        }
        complete(.success(data))
    }

}
