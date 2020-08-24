//
//  CharactersMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//

import Foundation
@testable import struct ComicsInfo.Character

struct CharactersMock {

    static let character1 = ComicsInfo.Character(
        identifier: "1",
        popularity: 0,
        name: "Name",
        thumbnail: nil,
        description: nil,
        series: []
    )

    static let character2 = ComicsInfo.Character(
        identifier: "2",
        popularity: 0,
        name: "Name",
        thumbnail: nil,
        description: nil,
        series: []
    )

}
