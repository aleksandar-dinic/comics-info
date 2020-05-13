//
//  CharacterViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import enum CIData.DataSourceLayer
import Foundation

final class CharacterViewModel: ObservableObject {

    enum Status: Equatable {
        case loading
        case error(message: String)
        case showCharacters
    }

    private var characterUseCaseAdapter: CharacterUseCaseAdapter
    private(set) var characters: [Character]

    @Published private(set) var status: Status {
        didSet {
            switch status {
            case let .error(message):
                showError = true
                errorMessage = message
            default:
                showError = false
                errorMessage = ""
            }
        }
    }
    @Published var showError: Bool = false
    private(set) var errorMessage: String = ""

    init(
        characterUseCaseAdapter: CharacterUseCaseAdapter = CharacterUseCaseAdapter(),
        characters: [Character] = [],
        status: Status = .loading
    ) {
        self.characterUseCaseAdapter = characterUseCaseAdapter
        self.characters = characters
        self.status = status
    }

    func loadCharacters(fromDataSource dataSource: CIData.DataSourceLayer = .memory) {
        guard dataSource == .network || characters.isEmpty else { return }

        characterUseCaseAdapter.getCharacters(fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(characters):
                self.characters = characters.sorted { $0.popularity < $1.popularity }
                self.status = .showCharacters
            case let .failure(error):
                self.status = .error(message: error.localizedDescription)
            }
        }
    }

    func loadCharacter(
        withID characterID: String,
        fromDataSource dataSource: CIData.DataSourceLayer = .memory
    ) {
        guard dataSource == .network || !characters.contains(where: { $0.identifier == characterID }) else { return }

        characterUseCaseAdapter.getCharacter(withID: characterID, fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(character):
                if let index = self.characters.firstIndex(where: { $0.identifier == character.identifier }) {
                    self.characters[index] = character
                } else {
                    self.characters.append(character)
                }
                self.status = .showCharacters
            case let .failure(error):
                self.status = .error(message: error.localizedDescription)
            }
        }
    }

}
