//
//  CharacterAPIProviderFactory.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol CharacterAPIProviderFactory {

    func makeCharacterAPIProvider() -> CharacterAPIProvider

}

extension CharacterAPIProviderFactory {

    public func makeCharacterAPIProvider() -> CharacterAPIProvider {
        CharacterAPIProvider()
    }

}
