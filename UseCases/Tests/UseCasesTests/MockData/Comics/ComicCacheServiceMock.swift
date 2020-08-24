//
//  ComicCacheServiceMock.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Comic
import protocol CIData.ComicCacheService
import Foundation

final class ComicCacheServiceMock: ComicCacheService {

    private var comics: [String: CIData.Comic]

    init(_ comics: [String: CIData.Comic] = [:]) {
        self.comics = comics
    }

    func getAllComics(forSeriesID seriesID: String) -> [CIData.Comic]? {
        guard !comics.isEmpty else {
            return nil
        }
        return Array(comics.values.filter { $0.seriesID.contains(seriesID) })
    }

    func getComic(withID comicID: String) -> CIData.Comic? {
        comics[comicID]
    }

    func save(comics: [CIData.Comic]) {
        for comic in comics {
            self.comics[comic.identifier] = comic
        }
    }

}

extension ComicCacheServiceMock {

    func setComics(_ comics: [CIData.Comic]) {
        for comic in comics {
            self.comics[comic.identifier] = comic
        }
    }

}
