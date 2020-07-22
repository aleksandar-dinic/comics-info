//
//  ComicAPIServiceMock.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.ComicAPIService
import Foundation

final class ComicAPIServiceMock: ComicAPIService {

    private let data: Data?

    init(_ data: Data? = nil) {
        self.data = data
    }

    func getComics(
        forSeriesID seriesID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let data = data else {
            return complete(.failure(ErrorMock.noData))
        }
        complete(.success(data))
    }

}
