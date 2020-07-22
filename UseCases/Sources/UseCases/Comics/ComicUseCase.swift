//
//  ComicUseCase.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.ComicRepository
import enum CIData.DataSourceLayer
import struct Domain.Comic
import Foundation

public final class ComicUseCase {

    private let comicRepository: ComicRepository

    init(comicRepository: ComicRepository) {
        self.comicRepository = comicRepository
    }

    public func getComics(
        forSeriesID seriesID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Domain.Comic], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.comicRepository.getComics(forSeriesID: seriesID, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }

}
