//
//  ComicAPIProviderFactory.swift
//  Framework
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol ComicAPIProviderFactory {

    func makeComicAPIProvider() -> ComicAPIProvider

}

extension ComicAPIProviderFactory {

    public func makeComicAPIProvider() -> ComicAPIProvider {
        ComicAPIProvider()
    }

}
