//
//  ComicRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol ComicRepository {

    var comicDataProvider: ComicDataProvider { get }

    init(comicDataProvider: ComicDataProvider)

    /// Gets all comics
    ///
    /// - Parameters:
    ///   - seriesID: Series ID
    ///   - dataSource: Layer of data source
    ///   - complete: Result who contains list of Comic Summaries in Success, or Error in Failure.
    func getAllComics(
        for seriesID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    )
    
    /// Gets comic
    ///
    /// - Parameters:
    ///   - dataSource: Layer of data source
    ///   - complete: Result who contains Comics in Success, or Error in Failure.
    func getComic(
        withID comicID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Comic, Error>) -> Void
    )

}
