//
//  ComicAPIService.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol ComicAPIService {

    func getAllComics(
        for seriesID: String,
        afterID: String?,
        limit: Int,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
    func getComic(
        withID comicID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )

}
