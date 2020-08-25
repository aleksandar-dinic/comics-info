//
//  CharactersWithSeriesUseCase.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Character
import enum CIData.DataSourceLayer
import Foundation

public final class CharactersWithSeriesUseCase {

    private var characterUseCase: CharacterUseCase
    private var seriesUseCase: SeriesUseCase

    init(
        characterUseCase: CharacterUseCase,
        seriesUseCase: SeriesUseCase
    ) {
        self.characterUseCase = characterUseCase
        self.seriesUseCase = seriesUseCase
    }

    public func getAllCharactersWithSeries(
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[CIData.Character], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.characterUseCase.getAllCharacters(fromDataSource: dataSource) { [weak self] result in
                switch result {
                case let .success(characters):
                    self?.getAllSeries(forCharacters: characters, fromDataSource: dataSource, onComplete: complete)

                case let .failure(error):
                    DispatchQueue.main.async {
                        complete(.failure(error))
                    }
                }
            }
        }
    }

    private func getAllSeries(
        forCharacters characters: [Character],
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }

            var charactersDict = [String: Character]()
            for character in characters {
                charactersDict[character.identifier] = character
            }

            self.seriesUseCase.getAllSeries(
                forCharacters: Array(charactersDict.keys),
                fromDataSource: dataSource
            ) { result in
                switch result {
                case let .success(series):
                    series.forEach {
                        for characterID in $0.charactersID {
                            charactersDict[characterID]?.series.append($0)
                        }
                    }
                    DispatchQueue.main.async {
                        complete(.success(Array(charactersDict.values)))
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        complete(.failure(error))
                    }
                }
            }
        }
    }

}
