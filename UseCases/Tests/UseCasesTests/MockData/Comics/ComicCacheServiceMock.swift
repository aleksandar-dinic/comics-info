//
//  ComicCacheServiceMock.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import protocol CIData.ComicCacheService
import Foundation

final class ComicCacheServiceMock: ComicCacheService {

    private var comics: [String: Domain.Comic]

    init(_ comics: [String: Domain.Comic] = [:]) {
        self.comics = comics
    }

    func getComics(forSeriesID seriesID: String) -> [Domain.Comic]? {
        guard !comics.isEmpty else {
            return nil
        }
        return Array(comics.values.filter { $0.seriesID.contains(seriesID) })
    }

    func getComic(withID comicID: String) -> Domain.Comic? {
        comics[comicID]
    }

    func save(comics: [Domain.Comic]) {
        for comic in comics {
            self.comics[comic.identifier] = comic
        }
    }

}

extension ComicCacheServiceMock {

    func setComics(_ data: Data?) {
        guard let data = data else {
            return
        }

        do {
            let comics = try JSONDecoder().decode([Domain.Comic].self, from: data)
            for comic in comics {
                self.comics[comic.identifier] = comic
            }
        } catch {
            print(error)
        }
    }

}
