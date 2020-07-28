//
//  ComicAPIProvider.swift
//  Framework
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.ComicAPIService
import Foundation

public struct ComicAPIProvider: CIData.ComicAPIService {

    public func getComics(
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
