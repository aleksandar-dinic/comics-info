//
//  CharacterUseCase.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Character
import protocol CIData.CharacterRepository
import enum CIData.DataSourceLayer
import Foundation

public final class CharacterUseCase {

    private let characterRepository: CharacterRepository

    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }

    public func getAllCharacters(
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[CIData.Character], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.characterRepository.getAllCharacters(fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }

    public func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<CIData.Character, Error>) -> Void
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
