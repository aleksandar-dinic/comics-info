//
//  SeriesCacheProviderFactory.swift
//  Framework
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol SeriesCacheProviderFactory {

    func makeSeriesCacheProvider() -> SeriesCacheProvider

}

extension SeriesCacheProviderFactory {

    public func makeSeriesCacheProvider() -> SeriesCacheProvider {
        SeriesCacheProvider()
    }

}
