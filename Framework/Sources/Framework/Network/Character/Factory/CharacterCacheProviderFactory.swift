//
//  CharacterCacheProviderFactory.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol CharacterCacheProviderFactory {

    func makeCharacterCacheProvider() -> CharacterCacheProvider

}

extension CharacterCacheProviderFactory {

    public func makeCharacterCacheProvider() -> CharacterCacheProvider {
        CharacterCacheProvider()
    }

}
