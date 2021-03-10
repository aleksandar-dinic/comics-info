//
//  ComicUseCase.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.ComicRepository
import enum CIData.DataSourceLayer
import struct CIData.Comic
import Foundation

public final class ComicUseCase {

    private let comicRepository: ComicRepository

    init(comicRepository: ComicRepository) {
        self.comicRepository = comicRepository
    }

    public func getAllComics(
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[CIData.Comic], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.comicRepository.getAllComics(fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    public func getComic(
        withID comicID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<CIData.Comic, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.comicRepository.getComic(withID: comicID, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }

}
