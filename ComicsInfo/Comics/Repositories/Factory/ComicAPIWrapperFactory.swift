//
//  ComicAPIWrapperFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol ComicAPIWrapperFactory {

    var comicAPIService: ComicAPIService { get }

    func makeComicAPIWrapper() -> ComicAPIWrapper

}

extension ComicAPIWrapperFactory {

    func makeComicAPIWrapper() -> ComicAPIWrapper {
        ComicAPIWrapper(comicAPIService: comicAPIService)
    }

}
