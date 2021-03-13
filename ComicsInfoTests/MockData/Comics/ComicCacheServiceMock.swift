//
//  ComicCacheServiceMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct ComicsInfo.Comic
@testable import protocol ComicsInfo.ComicCacheService
import Foundation

final class ComicCacheServiceMock: ComicCacheService {

    private var comics: [String: Comic]

    init(_ comics: [String: Comic] = [:]) {
        self.comics = comics
    }

    func getAllComics() -> [Comic]? {
        !comics.isEmpty ? Array(comics.values) : nil
    }

    func getComic(withID comicID: String) -> Comic? {
        comics[comicID]
    }

    func save(comics: [Comic]) {
        for comic in comics {
            self.comics[comic.identifier] = comic
        }
    }

}

extension ComicCacheServiceMock {

    func setComics(_ comics: [Comic]) {
        for comic in comics {
            self.comics[comic.identifier] = comic
        }
    }

}
