//
//  ComicDecoderMock.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import protocol CIData.ComicDecoderService
import Foundation

final class ComicDecoderMock: CIData.ComicDecoderService {

    private let comics: [Domain.Comic]

    init(_ comics: [Domain.Comic] = []) {
        self.comics = comics
    }

    func decodeAllComics(from data: Data) -> Result<[Domain.Comic], Error> {
        !comics.isEmpty ? .success(comics) : .failure(ErrorMock.noData)
    }

}
