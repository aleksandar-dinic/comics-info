//
//  CharacterDataProviderFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol CharacterDataProviderFactory: CharacterAPIWrapperFactory {

    var characterCacheService: CharacterCacheService { get }

    func makeCharacterDataProvider() -> CharacterDataProvider

}

extension CharacterDataProviderFactory {

    func makeCharacterDataProvider() -> CharacterDataProvider {
        CharacterDataProvider(
            characterAPIWrapper: makeCharacterAPIWrapper(),
            characterCacheService: characterCacheService
        )
    }

}
