//
//  CharacterInfoViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 08/09/2021.
//

import Foundation

final class CharacterInfoViewModel: LoadableObject {

    @Published private(set) var state: LoadingState<Void>
    private let character: Character
    private let characterUseCase: CharacterUseCase
    @Published var isInMyCharacters: Bool
    @Published var isBookmarked: Bool
    
    init(
        state: LoadingState<Void> = .idle,
        from character: Character,
        characterUseCase: CharacterUseCase = CharacterUseCase(),
        isInMyCharacters: Bool = false,
        isBookmarked: Bool = false
    ) {
        self.state = state
        self.character = character
        self.characterUseCase = characterUseCase
        self.isInMyCharacters = isInMyCharacters
        self.isBookmarked = isBookmarked
    }
    
    var name: String {
        character.name
    }
    
    var realName: String {
        character.realName ?? ""
    }
    
    var birthday: String {
        character.birth?.toString() ?? ""
    }
    
    var description: String {
        character.description ?? ""
    }
    
    var thumbnail: String {
        character.thumbnail ?? ""
    }
    
    var thumbnailSystemName: String {
        "person.crop.circle"
    }
    
    // My Characters
    
    func onTapAdd() {
        guard !isLoading else { return }
        state = .loading(currentValue: nil)
        
        isInMyCharacters() { [weak self] inMyCharacters in
            guard let self = self else { return }
            if inMyCharacters {
                self.characterUseCase.removeMyCharacter(withID: self.character.identifier) { _ in
                    self.isInMyCharacters = false
                    self.state = .loaded(())
                }
            } else {
                self.characterUseCase.addToMyCharacters(MyCharacter(from: self.character)) { _ in
                    self.isInMyCharacters = true
                    self.state = .loaded(())
                }
            }
        }
    }
    
    func isInMyCharacters(onComplete complete: @escaping (Bool) -> Void) {
        characterUseCase.isInMyCharacters(withID: character.identifier) { [weak self] result in
            guard let self = self else { return }
            do {
                try result.get()
                self.isInMyCharacters = true
            } catch {
                self.isInMyCharacters = false
            }
            complete(self.isInMyCharacters)
        }
    }
        
    // Bookmark
    
    func onTapBookmark() {
        let myCharacter = MyCharacter(from: character)
        if !isBookmarked {
            characterUseCase.addToBookmark(myCharacter)
        } else {
            characterUseCase.removeFromBookmark(myCharacter)
        }
    }
    
    func isInBookmark() {
        isBookmarked = characterUseCase.isBookmarked(withID: character.identifier)
    }
    
    var shereMessage: String {
        "Find more information about \(name) in the \"Comics Info\" app."
    }
    
}
