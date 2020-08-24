//
//  SeriesDecoderService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import Foundation

public protocol SeriesDecoderService {

    func decodeAllSeries(from data: Data) -> Result<[Domain.Series], Error>

}
