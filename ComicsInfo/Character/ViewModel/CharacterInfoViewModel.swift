//
//  CharacterInfoViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 08/09/2021.
//

import Foundation

struct CharacterInfoViewModel {

    private let character: Character
    
    init(from character: Character) {
        self.character = character
    }
    
    var name: String {
        character.name
    }
    
    var thumbnail: String {
        character.thumbnail ?? ""
    }
    
    var thumbnailSystemName: String {
        "person.crop.circle"
    }
    
}
