//
//  MockData.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol MockData {

    var identifier: String { get }
    var data: Data? { get }
    var json: String { get }

}

protocol MockSeries: MockData {

    var charactersID: Set<String> { get }

}

protocol MockComic: MockData {

    var seriesID: Set<String> { get }

}
