//
//  ExploreViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class ExploreViewModel: ObservableObject {

    private let characterUseCase: CharacterUseCase
    private(set) var characters: [Character]
    private var charactersIdentifier = Set<String>()
    @Published private(set) var status: LoadingState<[Character]>
    @Published private(set) var canLoadMore = true
    @Published var showBanner: Bool
    var alertController: AlertController?

    init(
        characterUseCase: CharacterUseCase = CharacterUseCase(),
        characters: [Character] = [],
        status: LoadingState<[Character]> = .idle,
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
        guard !status.isLoading(), canLoadMore else { return }
        
        status = .loading(currentValue: characters)
        characterUseCase.getAllCharacters(afterID: lastID, fields: fields, limit: limit, fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(characters):
                for character in characters where !self.charactersIdentifier.contains(character.identifier) {
                    self.characters.append(character)
                    self.charactersIdentifier.insert(character.identifier)
                }
                self.canLoadMore = characters.count >= limit
                self.status = .loaded(self.characters)
            case .failure:
                self.canLoadMore = false
                guard self.characters.isEmpty else { return }
                self.alertController?.info = AlertInfo(title: "Something went wrong. Please try again later ❤️")
            }
        }
    }
        
    var lastIdentifier: String? {
        characters.last?.identifier
    }

    func makeCharacterInfoViewModel(for character: Character) -> CharacterInfoViewModel {
        CharacterInfoViewModel(from: character, characterUseCase: characterUseCase)
    }
    
}
