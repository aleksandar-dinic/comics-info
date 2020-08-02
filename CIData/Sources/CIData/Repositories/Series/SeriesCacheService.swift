//
//  SeriesCacheService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import Foundation

public protocol SeriesCacheService {

    func getAllSeries(forCharacterID characterID: String) -> [Domain.Series]?

    func getSeries(withID seriesID: String) -> Domain.Series?

    func save(series: [Domain.Series])

}
