//
//  ComicRepositoryMockFactory.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
@testable import UseCases
import protocol CIData.ComicRepository
import Foundation

struct ComicRepositoryMockFactory {

    static func makeWithComics() -> ComicRepository {
        let comicDataProvider = ComicDataProviderMockFactory.makeWithComics()

        return ComicDataRepository(comicDataProvider: comicDataProvider)
    }

}
