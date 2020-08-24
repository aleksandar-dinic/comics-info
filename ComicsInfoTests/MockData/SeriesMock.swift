//
//  SeriesMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//

import Foundation
@testable import struct ComicsInfo.Series

struct SeriesMock {

    static let series1 = ComicsInfo.Series(
        identifier: "1",
        popularity: 0,
        title: "Title",
        thumbnail: nil,
        description: nil,
        startYear: nil,
        endYear: nil,
        charactersID: ["1"]
    )

    static let series2 = ComicsInfo.Series(
        identifier: "2",
        popularity: 0,
        title: "Title",
        thumbnail: nil,
        description: nil,
        startYear: nil,
        endYear: nil,
        charactersID: ["1"]
    )

}
