//
//  CharacterRepository.swift
//  CIData
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import Foundation

public protocol CharacterRepository {

    var characterDataProvider: CharacterDataProvider { get }

    init(characterDataProvider: CharacterDataProvider)

    /// Gets characters
    ///
    /// - Parameters:
    ///   - dataSource: Layer of data source
    ///   - complete: Result who contains Characters in Success, or Error in Failure
    func getCharacters(
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Domain.Character], Error>) -> Void
    )

    /// Gets character
    ///
    /// - Parameters:
    ///   - characterID: Character ID.
    ///   - dataSource: Layer of data source
    ///   - complete: Result who contains Character in Success, or Error in Failure
    func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Domain.Character, Error>) -> Void
    )

}
