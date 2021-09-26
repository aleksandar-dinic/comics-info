//
//  SeriesAPIWrapperFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol SeriesAPIWrapperFactory {

    var seriesAPIService: SeriesAPIService { get }

    func makeSeriesAPIWrapper() -> SeriesAPIWrapper

}

extension SeriesAPIWrapperFactory {

    func makeSeriesAPIWrapper() -> SeriesAPIWrapper {
        SeriesAPIWrapper(seriesAPIService: seriesAPIService)
    }

}
