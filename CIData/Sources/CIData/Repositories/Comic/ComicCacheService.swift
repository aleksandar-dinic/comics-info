//
//  ComicCacheService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import Foundation

public protocol ComicCacheService {

    func getAllComics(forSeriesID seriesID: String) -> [Domain.Comic]?

    func getComic(withID comicID: String) -> Domain.Comic?

    func save(comics: [Domain.Comic])

}
