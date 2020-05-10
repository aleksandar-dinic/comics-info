//
//  MockCharacter.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol MockCharacter {

    var identifier: String { get }
    var data: Data? { get }
    var json: String { get }

}
