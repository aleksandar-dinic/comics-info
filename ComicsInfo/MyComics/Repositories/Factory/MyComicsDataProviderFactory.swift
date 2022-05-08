//
//  MyComicsDataProviderFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/2/22.
//

import Foundation

protocol MyComicsDataProviderFactory: MyComicsAPIWrapperFactory {

    var myComicsCacheService: MyComicsCacheService { get }

    func makeMyComicsDataProvider() -> MyComicsDataProvider

}

extension MyComicsDataProviderFactory {

    func makeMyComicsDataProvider() -> MyComicsDataProvider {
        MyComicsDataProvider(
            myComicsAPIWrapper: makeMyComicsAPIWrapper(),
            myComicsCacheService: myComicsCacheService
        )
    }

}
