//
//  HTTPMethod.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2021.
//

import Foundation

struct HTTPMethod {

    static var GET: HTTPMethod { HTTPMethod(rawValue: "GET") }
    static var POST: HTTPMethod { HTTPMethod(rawValue: "POST") }
    static var PUT: HTTPMethod { HTTPMethod(rawValue: "PUT") }
    static var DELETE: HTTPMethod { HTTPMethod(rawValue: "DELETE") }

    let rawValue: String

}
