//
//  SeriesAPIWrapperFactory.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol SeriesAPIWrapperFactory {

    var seriesAPIService: SeriesAPIService { get }

    func makeSeriesAPIWrapper() -> SeriesAPIWrapper

}

extension SeriesAPIWrapperFactory {

    public func makeSeriesAPIWrapper() -> SeriesAPIWrapper {
        SeriesAPIWrapper(seriesAPIService: seriesAPIService)
    }

}
