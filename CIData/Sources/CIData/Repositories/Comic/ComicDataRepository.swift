//
//  ComicDataRepository.swift
//  CIData
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class ComicDataRepository: ComicRepository {

    var comicDataProvider: ComicDataProvider

    init(comicDataProvider: ComicDataProvider) {
        self.comicDataProvider = comicDataProvider
    }

    func getAllComics(
        forSeriesID seriesID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Comic], Error>) -> Void
    ) {
        comicDataProvider.getAllComics(
            forSeriesID: seriesID,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }

}
