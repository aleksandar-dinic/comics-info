//
//  SeriesCacheServiceMock.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import protocol CIData.SeriesCacheService
import Foundation

final class SeriesCacheServiceMock: SeriesCacheService {

    private var series: [String: Domain.Series]

    init(_ series: [String: Domain.Series] = [:]) {
        self.series = series
    }

    func getSeries(forCharacterID characterID: String) -> [Domain.Series]? {
        guard !series.isEmpty else {
            return nil
        }
        return Array(series.values.filter { $0.charactersID.contains(characterID) })
    }

    func getSeries(withID seriesID: String) -> Domain.Series? {
        series[seriesID]
    }

    func save(series: [Domain.Series]) {
        for ser in series {
            self.series[ser.identifier] = ser
        }
    }

}

extension SeriesCacheServiceMock {

    func setSeries(_ data: Data?) {
        guard let data = data else {
            return
        }

        do {
            let series = try JSONDecoder().decode([Domain.Series].self, from: data)
            for ser in series {
                self.series[ser.identifier] = ser
            }
        } catch {
            print(error)
        }
    }

}
