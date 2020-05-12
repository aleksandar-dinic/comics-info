//
//  CharacterAPIWrapperFactory.swift
//  CIData
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol CharacterAPIWrapperFactory {

    var characterAPIService: CharacterAPIService { get }

    func makeCharacterAPIWrapper() -> CharacterAPIWrapper

}

extension CharacterAPIWrapperFactory {

    public func makeCharacterAPIWrapper() -> CharacterAPIWrapper {
        CharacterAPIWrapper(characterAPIService: characterAPIService)
    }

}
