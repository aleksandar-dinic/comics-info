//
//  ComicUseCaseAdapter.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol UseCases.ComicUseCaseFactory
import enum CIData.DataSourceLayer
import protocol CIData.ComicAPIService
import protocol CIData.ComicCacheService
import Foundation

struct ComicUseCaseAdapter: UseCases.ComicUseCaseFactory {

    private lazy var useCase = makeComicUseCase()

    let comicAPIService: ComicAPIService
    let comicCacheService: ComicCacheService

    init(
        comicAPIService: ComicAPIService = ComicAPIProvider(),
        comicCacheService: ComicCacheService = ComicCacheProvider()
    ) {
        self.comicAPIService = comicAPIService
        self.comicCacheService = comicCacheService
    }

    mutating func getAllComics(
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Comic], Error>) -> Void
    ) {
        useCase.getAllComics(fromDataSource: dataSource) { result in
            complete(result.map { $0.map { Comic(from: $0) } })
        }
    }
    
    mutating func getComic(
        withID comicID: String,
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<Comic, Error>) -> Void
    ) {
        useCase.getComic(withID: comicID, fromDataSource: dataSource) { result in
            complete(result.map { Comic(from: $0) })
        }
    }

}
