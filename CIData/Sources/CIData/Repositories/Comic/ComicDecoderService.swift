//
//  ComicDecoderService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import Foundation

public protocol ComicDecoderService {

    func decodeAllComics(from data: Data) -> Result<[Domain.Comic], Error>

}
