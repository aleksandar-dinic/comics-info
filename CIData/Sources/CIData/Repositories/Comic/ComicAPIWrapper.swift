//
//  ComicAPIWrapper.swift
//  CIData
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct ComicAPIWrapper {

    private let comicAPIService: ComicAPIService
    private let comicDecoderService: ComicDecoderService

    init(
        comicAPIService: ComicAPIService,
        comicDecoderService: ComicDecoderService
    ) {
        self.comicAPIService = comicAPIService
        self.comicDecoderService = comicDecoderService
    }

    func getAllComics(
        forSeriesID seriesID: String,
        onComplete complete: @escaping (Result<[Comic], Error>) -> Void
    ) {
        comicAPIService.getAllComics(forSeriesID: seriesID) { result in
            switch result {
            case let .success(data):
                let decodedResult = comicDecoderService.decodeAllComics(from: data)
                complete(decodedResult.map({ $0.map({ Comic(from: $0) }) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
