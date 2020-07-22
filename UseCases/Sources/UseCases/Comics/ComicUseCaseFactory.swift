//
//  ComicUseCaseFactory.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.ComicRepositoryFactory
import Foundation

public protocol ComicUseCaseFactory: CIData.ComicRepositoryFactory {

    func makeComicUseCase() -> ComicUseCase

}

extension ComicUseCaseFactory {

    public func makeComicUseCase() -> ComicUseCase {
        ComicUseCase(comicRepository: makeComicRepository())
    }

}
