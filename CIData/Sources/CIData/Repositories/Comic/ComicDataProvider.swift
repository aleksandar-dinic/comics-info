//
//  ComicDataProvider.swift
//  CIData
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct ComicDataProvider {

    private let comicAPIWrapper: ComicAPIWrapper
    private let comicCacheService: ComicCacheService

    init(
        comicAPIWrapper: ComicAPIWrapper,
        comicCacheService: ComicCacheService
    ) {
        self.comicAPIWrapper = comicAPIWrapper
        self.comicCacheService = comicCacheService
    }

    func getAllComics(
        forSeriesID seriesID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Comic], Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let comicsFromMemory = getAllComicsFromMemory(forSeriesID: seriesID) {
                return complete(.success(comicsFromMemory))
            }

        case .network:
            break
        }

        getAllComicsFromNetwork(forSeriesID: seriesID, onComplete: complete)
    }

    private func getAllComicsFromMemory(forSeriesID seriesID: String) -> [Comic]? {
        guard let comics = comicCacheService.getAllComics(forSeriesID: seriesID) else {
            return nil
        }
        return comics.isEmpty ? nil : comics
    }

    private func getAllComicsFromNetwork(
        forSeriesID seriesID: String,
        onComplete complete: @escaping (Result<[Comic], Error>) -> Void
    ) {
        comicAPIWrapper.getAllComics(forSeriesID: seriesID) { (result: Result<[Comic], Error>) in
            switch result {
            case let .success(comics):
                comicCacheService.save(comics: comics)
                complete(.success(comics))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
