//
//  SeriesDecoderMock.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import protocol CIData.SeriesDecoderService
import Foundation

final class SeriesDecoderMock: CIData.SeriesDecoderService {

    private let series: [Domain.Series]

    init(_ series: [Domain.Series] = []) {
        self.series = series
    }

    func decodeAllSeries(from data: Data) -> Result<[Domain.Series], Error> {
        !series.isEmpty ? .success(series) : .failure(ErrorMock.noData)
    }

}
