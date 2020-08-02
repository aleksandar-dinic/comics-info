//
//  ComicAPIWrapper.swift
//  CIData
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import Foundation

public struct ComicAPIWrapper: ResultDecoder {

    private let comicAPIService: ComicAPIService

    init(comicAPIService: ComicAPIService) {
        self.comicAPIService = comicAPIService
    }

    func getAllComics(
        forSeriesID seriesID: String,
        onComplete complete: @escaping (Result<[Domain.Comic], Error>) -> Void
    ) {
        comicAPIService.getAllComics(forSeriesID: seriesID) { result in
            complete(self.decode(result))
        }
    }

}
