//
//  ComicCacheService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol ComicCacheService {

    func getAllComics() -> [Comic]?

    func getComic(withID comicID: String) -> Comic?

    func save(comics: [Comic])

}
