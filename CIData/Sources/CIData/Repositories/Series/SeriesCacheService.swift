//
//  SeriesCacheService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol SeriesCacheService {

    func getAllSeries(forCharacters characters: [String]) -> [Series]?

    func getSeries(withID seriesID: String) -> Series?

    func save(series: [Series])

}
