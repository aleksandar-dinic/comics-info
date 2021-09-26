//
//  SeriesAPIService.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol SeriesAPIService {

    func getAllSeries(
        for characterID: String,
        afterID: String?,
        limit: Int,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
    func getSeries(
        withID seriesID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )

}
