//
//  MyComicsAPIWrapperFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/2/22.
//

import Foundation

protocol MyComicsAPIWrapperFactory {

    var myComicsAPIService: MyComicsAPIService { get }

    func makeMyComicsAPIWrapper() -> MyComicsAPIWrapper

}

extension MyComicsAPIWrapperFactory {

    func makeMyComicsAPIWrapper() -> MyComicsAPIWrapper {
        MyComicsAPIWrapper(myComicsAPIService: myComicsAPIService)
    }

}
