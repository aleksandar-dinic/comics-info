//
//  CharacterUseCaseFactory.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.CharacterRepositoryFactory
import Foundation

public protocol CharacterUseCaseFactory: CIData.CharacterRepositoryFactory {

    func makeCharacterUseCase() -> CharacterUseCase

}

extension CharacterUseCaseFactory {

    public func makeCharacterUseCase() -> CharacterUseCase {
        CharacterUseCase(characterRepository: makeCharacterRepository())
    }

}
