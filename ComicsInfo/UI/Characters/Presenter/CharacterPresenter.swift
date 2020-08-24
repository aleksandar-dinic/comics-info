//
//  CharacterPresenter.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CharacterPresenter {

    /// The unique ID of the character resource.
    let identifier: String

    /// The value of character popularity
    let popularity: Int

    /// The name of the character.
    let name: String

    /// The representative image for this character.
    let thumbnail: String

    ///  A short bio or description of the character
    let description: String

    /// A resource list containing series for this character.
    var series: [Series]

    /// The representative system image for this character.
    var thumbnailSystemName: String {
        "person.crop.circle"
    }

}

extension CharacterPresenter {

    init(from character: Character) {
        identifier = character.identifier
        popularity = character.popularity
        name = character.name
        thumbnail = character.thumbnail ?? ""
        description = character.description ?? ""
        series = [Series]()
    }

}
