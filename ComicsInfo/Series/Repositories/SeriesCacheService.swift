//
//  SeriesCacheService.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol SeriesCacheService {

    func getAllSeries(
        for characterID: String,
        afterID: String?,
        limit: Int
    ) -> [SeriesSummary]?
    func save(seriesSummaries: [SeriesSummary], forCharacterID characterID: String)

    func getSeries(withID seriesID: String) -> Series?
    func save(series: Series)

}
