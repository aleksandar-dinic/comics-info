//
//  ComicAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.ComicAPIService
import Foundation

public struct ComicAPIProvider: CIData.ComicAPIService {

    public func getAllComics(
        forSeriesID seriesID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        usleep(useconds_t(Int.random(in: 500_000...2_000_000)))
        guard let data = ComicsMock(forSeriesID: seriesID).data else {
            return complete(.failure(NetworkError.noData))
        }
        complete(.success(data))
    }

}
