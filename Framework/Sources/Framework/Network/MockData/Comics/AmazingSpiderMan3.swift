//
//  AmazingSpiderMan3.swift
//  Framework
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct AmazingSpiderMan3: MockComic {

    let identifier = "3"
    let seriesID: Set<String> = ["1"]
    let charactersID: Set<String> = ["1"]
    private let popularity = 0
    private let title = "Spider-Man Versus Doctor Octopus"
    private let description = """
        Spider-Man catches Charlie and his two pals robbing a warehouse. Surprising them with his Spider \
        Signal light, he quickly overcomes them and webs them up for the police. Meanwhile, atomic scientist \
        Otto Octavius, known to his colleagues as Doctor Octopus because of the unique set of four \
        remote-controlled arms he invented for handling radioactive material, is hard at work at the \
        U.S. Atomic Research Center. Suddenly his experiment goes awry. In the ensuing explosion, Otto \
        Octavius's mechanical arms fuse to his body, and the excess radiation alters his brain. When he \
        awakens at Bliss Private Hospital, he discovers that he can make his mechanical arms move by thought \
        alone, just as if they were his real arms. With his brain unbalanced, Dr. Octopus forcibly takes over \
        the hospital as his first criminal act.
        """
    private let thumbnail = "AmazingSpiderMan3"
    private let issueNumber = "3"
    private let published = Date()

    var data: Data? {
        json.data(using: .utf8)
    }

    var json: String {
        """
        { \
        "identifier": "\(identifier)", \
        "popularity": \(popularity), \
        "title": "\(title)", \
        "issueNumber": "\(issueNumber)", \
        "description": "\(description)", \
        "thumbnail": "\(thumbnail)", \
        "seriesID": ["1"], \
        "charactersID": ["1"], \
        "published": \(published.timeIntervalSince1970) \
        }
        """
    }

}
