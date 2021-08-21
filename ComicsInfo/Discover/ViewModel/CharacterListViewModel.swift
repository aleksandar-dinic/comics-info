//
//  CharacterListViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class CharacterListViewModel: ObservableObject {

    enum Status: Equatable {
        case loading
        case error(message: String)
        case showCharacters
    }

    private var useCase: CharacterUseCase
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
        useCase: CharacterUseCase = CharacterUseCase(),
        characters: [Character] = [],
        status: Status = .loading
    ) {
        self.useCase = useCase
        self.characters = characters
        self.status = status
    }

    func loadAllCharacters(
        lastID: String? = nil,
        limit: Int = 20,
        fromDataSource dataSource: DataSourceLayer = .memory
    ) {
        useCase.getAllCharacters(fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(characters):
                self.characters = characters
                self.status = .showCharacters
            case let .failure(error):
                self.status = .error(message: error.localizedDescription)
            }
        }
    }

    func loadCharacter(
        withID characterID: String,
        fromDataSource dataSource: DataSourceLayer = .memory
    ) {
        useCase.getCharacter(withID: characterID, fromDataSource: dataSource) { [weak self] result in
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
