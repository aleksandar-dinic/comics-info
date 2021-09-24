//
//  ExploreViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class ExploreViewModel: ObservableObject {

    enum Status: Equatable {
        case loading
        case error(message: String)
        case showCharacters
    }

    private var characterUseCase: CharacterUseCase
    private(set) var characters: [Character]
    private var charactersIdentifier = Set<String>()
    @Published private(set) var canLoadMore = true
    @Published private(set) var isLoading = false
    @Published var showBanner = false

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
        characterUseCase: CharacterUseCase = CharacterUseCase(),
        characters: [Character] = [],
        status: Status = .loading,
        showBanner: Bool = AppTrackingManager.authorization
    ) {
        self.characterUseCase = characterUseCase
        self.characters = characters
        self.status = status
        self.showBanner = showBanner
    }

    func getAllCharacters(
        lastID: String? = nil,
        fields: Set<String>? = nil,
        limit: Int = 20,
        fromDataSource dataSource: DataSourceLayer = .memory
    ) {
        guard !isLoading, canLoadMore else { return }
        
        isLoading = true
        status = .loading
        characterUseCase.getAllCharacters(afterID: lastID, fields: fields, limit: limit, fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case let .success(characters):
                for character in characters where !self.charactersIdentifier.contains(character.identifier) {
                    self.characters.append(character)
                    self.charactersIdentifier.insert(character.identifier)
                }
                self.canLoadMore = characters.count >= limit
                self.status = .showCharacters
            case .failure:
                self.canLoadMore = false
                guard self.characters.isEmpty else { return }
                self.status = .error(message: "Something went wrong. Please try again later ❤️")
            }
        }
    }
        
    var lastIdentifier: String? {
        characters.last?.identifier
    }

}
