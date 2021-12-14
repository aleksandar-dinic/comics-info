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
    private let characterRepository: CharacterRepository
    private let seriesRepository: SeriesRepository

    init(
        comicAPIWrapper: ComicAPIWrapper,
        comicCacheService: ComicCacheService,
        characterRepository: CharacterRepository,
        seriesRepository: SeriesRepository
    ) {
        self.comicAPIWrapper = comicAPIWrapper
        self.comicCacheService = comicCacheService
        self.characterRepository = characterRepository
        self.seriesRepository = seriesRepository
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
            case let .success(comicSummaries):
                comicCacheService.save(comicSummaries: comicSummaries, forSeriesID: seriesID)
                complete(.success(comicSummaries))

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
                comicCacheService.save(comic: comic)
                complete(.success(comic))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

    // My Comics
    
    func getMyComics(forSeriesID seriesID: String) -> [ComicSummary]? {
        comicCacheService.getMyComics(forSeriesID: seriesID)
    }
    
    func addInMyComics(
        _ comicSummary: ComicSummary,
        character: Character,
        seriesSummary: SeriesSummary
    ) {
        comicCacheService.addInMyComics(comicSummaries: [comicSummary], forSeriesID: seriesSummary.identifier)
        var character = character
        character.addInMySeries(seriesSummary)
        characterRepository.addToMyCharacters(character)
    }
    
    func isInMyComics(_ comicID: String, forSeriesID seriesID: String) -> Bool {
        comicCacheService.isInMyComics(comicID, forSeriesID: seriesID)
    }
    
    // Add to bookmark
    
    func getBookmarkComics() -> [Comic]? {
        comicCacheService.getBookmarkComics()
    }
    
    func addToBookmark(_ comicID: String) {
        comicCacheService.addToBookmark(comicID)
    }
    
    func removeFromBookmark(_ comicID: String) {
        comicCacheService.removeFromBookmark(comicID)
    }
    
    func isBookmarked(withID comicID: String) -> Bool {
        comicCacheService.isBookmarked(withID: comicID)
    }

}
