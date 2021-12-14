//
//  CharacterInfoViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 08/09/2021.
//

import Foundation

struct CharacterInfoViewModel {

    private let character: Character
    private let characterUseCase: CharacterUseCase
    
    init(
        from character: Character,
        characterUseCase: CharacterUseCase = CharacterUseCase()
    ) {
        self.character = character
        self.characterUseCase = characterUseCase
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
        if !isInMyCharacters() {
            characterUseCase.addToMyCharacters(character)
        } else {
            characterUseCase.removeFromMyCharacters(character)
        }
    }
    
    func isInMyCharacters() -> Bool {
        characterUseCase.isInMyCharacters(withID: character.identifier)
    }
    
    // Bookmark
    
    func onTapBookmark() {
        if !isBookmarked() {
            characterUseCase.addToBookmark(character)
        } else {
            characterUseCase.removeFromBookmark(character)
        }
    }
    
    func isBookmarked() -> Bool {
        characterUseCase.isBookmarked(withID: character.identifier)
    }
    
    var shereMessage: String {
        "Find more information about \(name) in the \"Comics Info\" app."
    }
    
}
