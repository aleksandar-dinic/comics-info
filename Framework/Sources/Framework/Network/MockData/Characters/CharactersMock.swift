//
//  CharactersMock.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CharactersMock {

    private let mockCharacters: [MockCharacter]

    init(_ mockCharacters: [MockCharacter] = [
            SpiderManMock(),
            CaptainAmericaMock(),
            HulkMock(),
            IronManMock(),
            SilverSurferMock()
        ]
    ) {
        self.mockCharacters = mockCharacters
    }

    var data: Data? {
        "[\(mockCharacters.map { $0.json }.joined(separator: ","))]".data(using: .utf8)
    }

    var characters: [String: Data?] {
        var characters = [String: Data?]()
        for mock in mockCharacters {
            characters[mock.identifier] = mock.data
        }
        return characters
    }

}
