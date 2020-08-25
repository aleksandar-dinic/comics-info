//
//  CharactersWithSeriesUseCaseFactory.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol CharactersWithSeriesUseCaseFactory: CharacterUseCaseFactory, SeriesUseCaseFactory {

    func makeCharactersWithSeriesUseCase() -> CharactersWithSeriesUseCase

}

extension CharactersWithSeriesUseCaseFactory {

    public func makeCharactersWithSeriesUseCase() -> CharactersWithSeriesUseCase {
        CharactersWithSeriesUseCase(
            characterUseCase: makeCharacterUseCase(),
            seriesUseCase: makeSeriesUseCase()
        )
    }

}
