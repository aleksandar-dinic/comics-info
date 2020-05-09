//
//  CharacterUseCase.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.CharacterRepository
import enum CIData.DataSourceLayer
import struct Domain.Character
import Foundation

public final class CharacterUseCase {

    private let characterRepository: CharacterRepository

    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }

    public func getCharacters(
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Domain.Character], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.characterRepository.getCharacters(fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }

    func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<Domain.Character, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.characterRepository.getCharacter(withID: characterID, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }

}
