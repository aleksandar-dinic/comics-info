//
//  SeriesAPIServiceMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import protocol ComicsInfo.SeriesAPIService
import Foundation

final class SeriesAPIServiceMock: SeriesAPIService {

    private let data: Data?

    init(_ data: Data? = nil) {
        self.data = data
    }

    func getAllSeries(
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let data = data else {
            return complete(.failure(ErrorMock.noData))
        }
        complete(.success(data))
    }
    
    func getSeries(
        withID seriesID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let data = data else {
            return complete(.failure(ErrorMock.noData))
        }
        complete(.success(data))
    }

}
