//
//  CharactersWithSeriesUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 02/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import enum CIData.DataSourceLayer
import Foundation

final class CharactersWithSeriesUseCase {

    private var characterUseCase: CharacterUseCaseAdapter
    private var seriesUseCase: SeriesUseCaseAdapter

    init(
        characterUseCase: CharacterUseCaseAdapter = CharacterUseCaseAdapter(),
        seriesUseCase: SeriesUseCaseAdapter = SeriesUseCaseAdapter()
    ) {
        self.characterUseCase = characterUseCase
        self.seriesUseCase = seriesUseCase
    }

    func getAllCharactersWithSeries(
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        characterUseCase.getAllCharacters(fromDataSource: dataSource) { [weak self] result in
            switch result {
            case let .success(characters):
                self?.getAllSeries(forCharacters: characters, fromDataSource: dataSource, onComplete: complete)
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

    private func getAllSeries(
        forCharacters characters: [Character],
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        var charactersDict = [String: Character]()
        for character in characters {
            charactersDict[character.identifier] = character
        }

        seriesUseCase.getAllSeries(forCharacters: Array(charactersDict.keys), fromDataSource: dataSource) { result in
            switch result {
            case let .success(series):
                series.forEach {
                    for characterID in $0.charactersID {
                        charactersDict[characterID]?.series.append($0)
                    }
                }
                complete(.success(Array(charactersDict.values)))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
