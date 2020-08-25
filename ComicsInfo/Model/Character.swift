//
//  Character.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Character
import struct CIData.Series
import Foundation

struct Character: Codable {

    /// The unique ID of the character resource.
    let identifier: String

    /// The value of character popularity
    let popularity: Int

    /// The name of the character.
    let name: String

    /// The representative image for this character.
    let thumbnail: String?

    ///  A short bio or description of the character
    let description: String?

    /// A resource list containing series for this character.
    var series: [Series]

}

extension Character {

    init(from character: CIData.Character) {
        identifier = character.identifier
        popularity = character.popularity
        name = character.name
        thumbnail = character.thumbnail
        description = character.description
        series = character.series.map({ Series(from: $0) })
    }

}

extension CIData.Character {

    init(from character: Character) {
        self.init(
            identifier: character.identifier,
            popularity: character.popularity,
            name: character.name,
            thumbnail: character.thumbnail,
            description: character.description,
            series: character.series.map({ CIData.Series(from: $0) })
        )
    }

}

extension Character: Hashable {

    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.identifier == rhs.identifier
    }

}

#if DEBUG
extension Character {

    static let flash = Character(
        identifier: "1",
        popularity: 0,
        name: "Flash",
        thumbnail: "Flash",
        description: "",
        series: [
            Series.theFlash,
            Series.theFlashVol2,
            Series.theFlashVol3
        ]
    )

    static let spiderMan = Character(
        identifier: "2",
        popularity: 1,
        name: "Spider-Man",
        thumbnail: "SpiderMan",
        description: """
            Bitten by a radioactive spider, high school student Peter Parker gained the speed, \
            strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start a career using his \
            new abilities. Taught that with great power comes great responsibility, Spidey has vowed to use his powers \
            to help people.
            """,
        series: [
            Series.amazingSpiderMan,
            Series.peterParkerTheSpectacularSpiderMan,
            Series.webOfSpiderMan,
            Series.theSpectacularSpiderMan,
            Series.amazingSpiderManVol5
        ]
    )

    static let hulk = Character(
        identifier: "3",
        popularity: 2,
        name: "Hulk",
        thumbnail: "Hulk",
        description: """
            Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce \
            Banner was transformed into the incredibly powerful creature called the Hulk. An all too often \
            misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.
            """,
        series: []
    )

    static let ironMan = Character(
        identifier: "4",
        popularity: 3,
        name: "Iron Man",
        thumbnail: "IronMan",
        description: """
            Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist \
            Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new \
            outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man.
            """,
        series: []
    )

    static let silverSurfer = Character(
        identifier: "5",
        popularity: 4,
        name: "Silver Surfer",
        thumbnail: "SilverSurfer",
        description: """
            When Zenn-La was threatened by the world-devouring entity known as Galactus, Norrin Radd \
            stood up for his home planet and offered to work for Galactus, finding him new planets to eat, in exchange \
            for saving his own. Years later, thse Surfer has protected Earth and many other planets, becoming one of \
            the greatest heroes in the universe.
            """,
        series: []
    )

    static let captainAmerica = Character(
        identifier: "6",
        popularity: 5,
        name: "Captain America",
        thumbnail: "CaptainAmerica",
        description: """
            Vowing to serve his country any way he could, young Steve Rogers took the super soldier \
            serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain \
            America is the living, breathing symbol of freedom and liberty.
            """,
        series: []
    )

    static let unknown = Character(
        identifier: "7",
        popularity: 6,
        name: "Unknown",
        thumbnail: "",
        description: "",
        series: []
    )

}
#endif
