//
//  ComicRepositoryFactory.swift
//  CIData
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol ComicRepositoryFactory: ComicDataProviderFactory {

    func makeComicRepository() -> ComicRepository

}

extension ComicRepositoryFactory {

    public func makeComicRepository() -> ComicRepository {
        ComicDataRepository(comicDataProvider: makeComicDataProvider())
    }

}
