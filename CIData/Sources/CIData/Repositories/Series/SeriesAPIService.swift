//
//  SeriesAPIService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol SeriesAPIService {

    func getAllSeries(
        forCharacterID characterID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )

}
