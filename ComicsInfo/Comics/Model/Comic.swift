//
//  Comic.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import Foundation

struct Comic: Codable {

    /// The unique ID of the comic resource.
    let identifier: String

    /// The value of comic popularity
    let popularity: Int

    /// The canonical title of the comic.
    let title: String

    /// The representative image for this comics.
    let thumbnail: String

    /// The number of the issue in the series.
    let issueNumber: String

    /// The preferred description of the comic.
    let description: String

    /// The publication format of the comic e.g. comic, hardcover, trade paperback.
    let format: String?

    /// The Int of story pages in the comic.
    let pageCount: Int?

    /// A resource list containing series ID to which this comic belongs.
    let seriesID: Set<String>

    /// A resource list containing characters ID which appear in this comic.
    let charactersID: Set<String>

    /// The date of publication for this comic.
    let published: Date?

    /// The representative system image for this comic.
    var thumbnailSystemName: String {
        "photo.on.rectangle"
    }

    var issue: String {
        "#\(issueNumber)"
    }

    var publishedDate: String {
        guard let published = published else { return "" }
        let formatter = DateFormatter()
        formatter.formatterBehavior = .behavior10_4
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return "(\(formatter.string(from: published)))"
    }

}

extension Comic {

    init(from comic: Domain.Comic) {
        identifier = comic.identifier
        popularity = comic.popularity
        title = comic.title
        thumbnail = comic.thumbnail ?? ""
        issueNumber = comic.issueNumber ?? ""
        description = comic.description ?? ""
        format = comic.format
        pageCount = comic.pageCount
        seriesID = comic.seriesID
        charactersID = comic.charactersID
        published = comic.published
    }

}

#if DEBUG
extension Comic {

    static let amazingSpiderMan1 = Comic(
        identifier: "1",
        popularity: 1,
        title: "Spider-Man",
        thumbnail: "AmazingSpiderMan1",
        issueNumber: "1",
        description: """
            With the Parker household desperate for money following the death of Ben Parker, Peter Parker \
            decides to continue in show business as Spider-Man. However, not only does he find it impossible \
            to cash his paycheck (made out to Spider-Man), but the irrational editorials by J. Jonah Jameson \
            in the Daily Bugle effectively quelch his career. Besides denouncing Spider-Man as a \
            publicity-seeking phony, J. Jonah Jameson also publishes articles lauding his son, John Jameson, \
            a courageous astronaut about to be launched into orbit in a space capsule. J. Jonah Jameson calls \
            his son a "real hero."
            """,
        format: nil,
        pageCount: nil,
        seriesID: ["4"],
        charactersID: ["2"],
        published: Date()
    )

    static let amazingSpiderMan2 = Comic(
        identifier: "2",
        popularity: 2,
        title: "Duel to the Death with the Vulture!",
        thumbnail: "AmazingSpiderMan2",
        issueNumber: "2",
        description: """
            New York City is being terrorized by a new criminal called the Vulture. He is equipped with \
            artificial wings that allow him to swoop down on his victims, snatch their valuables, and fly \
            away before they know what is happening. Nobody has been able to photograph him, and J. Jonah \
            Jameson needs pictures to illustrate his Vulture feature article for NOW Magazine. Peter Parker \
            decides to try to photograph the criminal in action. Selling the photographs will help him and \
            his Aunt May make ends meet.
            """,
        format: nil,
        pageCount: nil,
        seriesID: ["4"],
        charactersID: ["2"],
        published: Date()
    )

    static let amazingSpiderMan3 = Comic(
        identifier: "3",
        popularity: 3,
        title: "Spider-Man Versus Doctor Octopus",
        thumbnail: "AmazingSpiderMan3",
        issueNumber: "3",
        description: """
            Spider-Man catches Charlie and his two pals robbing a warehouse. Surprising them with his Spider \
            Signal light, he quickly overcomes them and webs them up for the police. Meanwhile, atomic scientist \
            Otto Octavius, known to his colleagues as Doctor Octopus because of the unique set of four \
            remote-controlled "arms" he invented for handling radioactive material, is hard at work at the \
            U.S. Atomic Research Center. Suddenly his experiment goes awry. In the ensuing explosion, Otto \
            Octavius's mechanical arms fuse to his body, and the excess radiation alters his brain. When he \
            awakens at Bliss Private Hospital, he discovers that he can make his mechanical arms move by thought \
            alone, just as if they were his real arms. With his brain unbalanced, Dr. Octopus forcibly takes over \
            the hospital as his first criminal act.
            """,
        format: nil,
        pageCount: nil,
        seriesID: ["4"],
        charactersID: ["2"],
        published: Date()
    )

    static let amazingSpiderMan4 = Comic(
        identifier: "4",
        popularity: 4,
        title: "Nothing Can Stop... the Sandman!",
        thumbnail: "AmazingSpiderMan4",
        issueNumber: "4",
        description: """
            Spider-Man sees a few punks casing a jewelry store and webs them up before they can rob it. \
            However, the thugs threaten to sue Spider-Man for assault and battery! Spider-Man must flee \
            when they call the cops, since all the evidence makes him look guilty. Spider-Man blames Jameson \
            for this treatment and leaves him a little souvenir in his office. After leaving Jameson's office, \
            Spider-Man runs into the Sandman on a rooftop. Sandman gets the best of Spider-Man, and Spider-Man's \
            mask is torn in the process, so he must flee before his identity is revealed. While at home sewing up \
            his mask, Peter Parker learns the identity of the Sandman during a news bulletin. Originally an escaped \
            convict, Sandman hid on a beach at a radioactive testing facility. During one of the tests, he was \
            exposed to radioactivity, and his body gained the power to act as if it were made of sand. The bulletin \
            also shows Sandman robbing a bank and fleeing the police.
            """,
        format: nil,
        pageCount: nil,
        seriesID: ["4"],
        charactersID: ["2"],
        published: Date()
    )

    static let amazingSpiderMan5 = Comic(
        identifier: "5",
        popularity: 5,
        title: "Marked for Destruction by Dr. Doom!",
        thumbnail: "AmazingSpiderMan5",
        issueNumber: "5",
        description: """
            After a report by J. Jonah Jameson about the "menace" of Spider-Man, Peter (in order to avoid \
            any suspicion that he's really Spider-Man) speaks negatively about his alter ego, earning him \
            harsh words from Flash Thompson. Meanwhile, Dr. Doom had seen this same report, and decided that \
            after surviving his last encounter battling the Fantastic Four, that perhaps Spider-Man would make \
            for a good partner to eliminate his mortal foes.
            """,
        format: nil,
        pageCount: nil,
        seriesID: ["4"],
        charactersID: ["2"],
        published: Date()
    )

}
#endif
