//
//  ComicAPIWrapper.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import Foundation

struct ComicAPIWrapper: DecoderService {

    private let comicAPIService: ComicAPIService

    init(comicAPIService: ComicAPIService) {
        self.comicAPIService = comicAPIService
    }

    func getAllComics(
        onComplete complete: @escaping (Result<[Comic], Error>) -> Void
    ) {
        comicAPIService.getAllComics() { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<[Domain.Comic], Error> = decode(from: data)
                complete(decodedResult.map({ $0.map({ Comic(from: $0) }) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func getComic(
        withID comicID: String,
        onComplete complete: @escaping (Result<Comic, Error>) -> Void
    ) {
        comicAPIService.getComic(withID: comicID) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<Domain.Comic, Error> = decode(from: data)
                complete(decodedResult.map({ Comic(from: $0) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
