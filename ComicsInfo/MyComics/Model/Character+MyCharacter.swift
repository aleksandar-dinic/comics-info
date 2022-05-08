//
//  Character+MyCharacter.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/2/22.
//

import Foundation

extension Character {
    
    init(from myCharacter: MyCharacter) {
        self.init(
            identifier: myCharacter.identifier,
            popularity: myCharacter.popularity,
            name: myCharacter.name,
            thumbnail: myCharacter.thumbnail,
            description: myCharacter.description,
            realName: myCharacter.realName,
            aliases: myCharacter.aliases,
            birth: myCharacter.birth,
            mainSeries: nil,
            mySeries: myCharacter.mySeries,
            comics: nil
        )
    }
    
}
