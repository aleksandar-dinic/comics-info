//
//  CharacterViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CharacterViewModel {
    
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
