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

    private var characterUseCase: CharacterUseCase
    @Published private(set) var characters: [Character]

    private(set) var errorMessage: String = "" {
        didSet {
            showError = errorMessage != ""
        }
    }
    @Published var showError: Bool
    @Published var isLoading: Bool

    init(
        characterUseCase: CharacterUseCase = CharacterUseCase(),
        characters: [Character] = [],
        showError: Bool = false,
        isLoading: Bool = true
    ) {
        self.characterUseCase = characterUseCase
        self.characters = characters
        self.showError = showError
        self.isLoading = isLoading
    }

    func loadCharacters(fromDataSource dataSource: CIData.DataSourceLayer = .memory) {
        guard dataSource == .network || characters.isEmpty else { return }

        characterUseCase.getCharacters(fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case let .success(characters):
                self.characters = characters.sorted { $0.popularity < $1.popularity }
                self.errorMessage = ""
            case let .failure(error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    func loadCharacter(
        withID characterID: String,
        fromDataSource dataSource: CIData.DataSourceLayer = .memory
    ) {
        guard dataSource == .network || !characters.contains(where: { $0.identifier == characterID }) else { return }

        characterUseCase.getCharacter(withID: characterID, fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case let .success(character):
                if let index = self.characters.firstIndex(where: { $0.identifier == character.identifier }) {
                    self.characters[index] = character
                } else {
                    self.characters.append(character)
                }
                self.errorMessage = ""
            case let .failure(error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

}
