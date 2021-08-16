//
//  ComicDataProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct ComicDataProvider {

    private let comicAPIWrapper: ComicAPIWrapper
    private let comicCacheService: ComicCacheService

    init(
        comicAPIWrapper: ComicAPIWrapper,
        comicCacheService: ComicCacheService
    ) {
        self.comicAPIWrapper = comicAPIWrapper
        self.comicCacheService = comicCacheService
    }
    
    // Get all comics

    func getComicSummaries(
        for seriesID: String,
        afterID: String?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let comicsFromMemory = getComicSummariesFromMemory(for: seriesID, afterID: afterID, limit: limit) {
                return complete(.success(comicsFromMemory))
            }
            fallthrough
        case .network:
            getComicSummariesFromNetwork(for: seriesID, afterID: afterID, limit: limit, onComplete: complete)
        }
    }

    private func getComicSummariesFromMemory(
        for seriesID: String,
        afterID: String?,
        limit: Int
    ) -> [ComicSummary]? {
        guard let comics = comicCacheService.getComicSummaries(for: seriesID, afterID: afterID, limit: limit) else {
            return nil
        }
        return comics.isEmpty ? nil : comics
    }

    private func getComicSummariesFromNetwork(
        for seriesID: String,
        afterID: String?,
        limit: Int,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        comicAPIWrapper.getAllComics(for: seriesID, afterID: afterID, limit: limit) { (result: Result<[ComicSummary], Error>) in
            switch result {
            case let .success(comics):
                comicCacheService.save(comicSummaries: [seriesID: comics])
                complete(.success(comics))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    // Get comic

    func getComic(
        withID comicID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Comic, Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let comicsFromMemory = getComicFromMemory(withID: comicID) {
                return complete(.success(comicsFromMemory))
            }
            fallthrough
        case .network:
            getComicFromNetwork(withID: comicID, onComplete: complete)
        }
    }

    private func getComicFromMemory(withID comicID: String) -> Comic? {
        comicCacheService.getComic(withID: comicID)
    }

    private func getComicFromNetwork(
        withID comicID: String,
        onComplete complete: @escaping (Result<Comic, Error>) -> Void
    ) {
        comicAPIWrapper.getComic(withID: comicID) { (result: Result<Comic, Error>) in
            switch result {
            case let .success(comic):
                comicCacheService.save(comics: [comic])
                complete(.success(comic))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}