//
//  Character.swift
//  Domain
//
//  Created by Aleksandar Dinic on 22/04/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct Character: Codable {

    /// The unique ID of the character resource.
    public let identifier: String

    /// The value of character popularity
    public let popularity: Int

    /// The name of the character.
    public let name: String

    /// The representative image for this character.
    public let thumbnail: String?

    ///  A short bio or description of the character
    public let description: String?

}
