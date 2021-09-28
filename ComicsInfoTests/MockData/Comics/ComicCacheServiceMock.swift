//
//  ComicCacheServiceMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Comics_Info__Development_.Comic
@testable import struct Comics_Info__Development_.ComicSummary
@testable import protocol Comics_Info__Development_.ComicCacheService
import Foundation

final class ComicCacheServiceMock: ComicCacheService {

    private var comics: [String: Comic]

    init(_ comics: [String: Comic] = [:]) {
        self.comics = comics
    }

    func getComicSummaries(for seriesID: String, afterID: String?, limit: Int) -> [ComicSummary]? {
        []
    }
    
    func save(comicSummaries: [ComicSummary], forSeriesID seriesID: String) {
    }

    func getComic(withID comicID: String) -> Comic? {
        comics[comicID]
    }

    func save(comic: Comic) {
        comics[comic.identifier] = comic
    }

}

extension ComicCacheServiceMock {

    func setComics(_ comics: [Comic]) {
        for comic in comics {
            self.comics[comic.identifier] = comic
        }
    }

}
