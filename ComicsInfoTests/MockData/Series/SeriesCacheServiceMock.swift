//
//  SeriesCacheServiceMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Comics_Info__Development_.Series
@testable import struct Comics_Info__Development_.SeriesSummary
@testable import protocol Comics_Info__Development_.SeriesCacheService
import Foundation

final class SeriesCacheServiceMock: SeriesCacheService {

    private var series: [String: Series]
    private var seriesSummaries: [String: SeriesSummary]

    init(
        series: [String: Series] = [:],
        seriesSummaries: [String: SeriesSummary] = [:]
    ) {
        self.series = series
        self.seriesSummaries = seriesSummaries
    }

    func getAllSeries(
        for characterID: String,
        afterID: String?,
        limit: Int
    ) -> [SeriesSummary]? {
        seriesSummaries.values.isEmpty ? nil : Array(seriesSummaries.values)
    }
    
    func save(seriesSummaries: [SeriesSummary], forCharacterID characterID: String) {
        
    }

    func getSeries(withID seriesID: String) -> Series? {
        series[seriesID]
    }

    func save(series: Series) {
        self.series[series.identifier] = series
    }

}

extension SeriesCacheServiceMock {

    func setSeries(_ series: [Series]) {
        series.forEach {
            self.series[$0.identifier] = $0
        }
    }

}
