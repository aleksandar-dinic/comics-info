//
//  ComicViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import enum CIData.DataSourceLayer
import Foundation

final class ComicViewModel: ObservableObject {

    enum Status: Equatable {
        case loading
        case error(message: String)
        case showComics
    }

    private var comicUseCaseAdapter: ComicUseCaseAdapter
    private(set) var comics: [Comic]

    @Published private(set) var status: Status {
        didSet {
            switch status {
            case let .error(message):
                showError = true
                errorMessage = message
            default:
                showError = false
                errorMessage = ""
            }
        }
    }
    @Published var showError: Bool = false
    private(set) var errorMessage: String = ""

    init(
        comicUseCaseAdapter: ComicUseCaseAdapter = ComicUseCaseAdapter(),
        comics: [Comic] = [],
        status: Status = .loading
    ) {
        self.comicUseCaseAdapter = comicUseCaseAdapter
        self.comics = comics
        self.status = status
    }

    func loadAllComics(
        forSeriesID seriesID: String,
        fromDataSource dataSource: CIData.DataSourceLayer = .memory
    ) {
        guard dataSource == .network || comics.filter({ $0.seriesID.contains(seriesID) }).isEmpty else { return }

        comicUseCaseAdapter.getAllComics(
            forSeriesID: seriesID,
            fromDataSource: dataSource
        ) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(comics):
                self.comics = comics.sorted { $0.popularity < $1.popularity }
                self.status = .showComics
            case let .failure(error):
                self.status = .error(message: error.localizedDescription)
            }
        }
    }

}
