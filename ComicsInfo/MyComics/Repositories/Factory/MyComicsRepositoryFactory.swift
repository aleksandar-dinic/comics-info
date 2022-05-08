//
//  MyComicsRepositoryFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/2/22.
//

import Foundation

protocol MyComicsRepositoryFactory: MyComicsDataProviderFactory {
    
    func makeMyComicsRepository() -> MyComicsRepository

}

extension MyComicsRepositoryFactory {

    func makeMyComicsRepository() -> MyComicsRepository {
        MyComicsRepository(myComicsDataProvider: makeMyComicsDataProvider())
    }

}
