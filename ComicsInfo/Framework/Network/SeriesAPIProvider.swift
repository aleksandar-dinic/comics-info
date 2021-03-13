//
//  SeriesAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SeriesAPIProvider: SeriesAPIService {

    func getAllSeries(onComplete complete: @escaping (Result<Data, Error>) -> Void) {
        usleep(useconds_t(Int.random(in: 500_000...2_000_000)))
        guard let data = SeriesMock().data else {
            return complete(.failure(NetworkError.noData))
        }
        complete(.success(data))
    }
    
    func getSeries(
        withID seriesID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        usleep(useconds_t(Int.random(in: 500_000...2_000_000)))
        guard let data = SeriesMock().data else {
            return complete(.failure(NetworkError.noData))
        }
        complete(.success(data))
    }

}
