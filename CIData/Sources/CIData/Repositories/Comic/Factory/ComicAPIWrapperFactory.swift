//
//  ComicAPIWrapperFactory.swift
//  CIData
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol ComicAPIWrapperFactory {

    var comicAPIService: ComicAPIService { get }

    func makeComicAPIWrapper() -> ComicAPIWrapper

}

extension ComicAPIWrapperFactory {

    public func makeComicAPIWrapper() -> ComicAPIWrapper {
        ComicAPIWrapper(comicAPIService: comicAPIService)
    }

}
