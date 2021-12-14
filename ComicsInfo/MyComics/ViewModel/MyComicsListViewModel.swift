//
//  MyComicsListViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 14/12/2021.
//

import Foundation

final class MyComicsListViewModel: ObservableObject {

    enum Status: Equatable {
        case loading
        case error(message: String)
        case showComics
    }

    private(set) var useCase: ComicUseCase
    private(set) var comics: [ComicSummary]
    private var comicsIdentifier = Set<String>()
    @Published private(set) var canLoadMore = true
    @Published private(set) var isLoading = false

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
        useCase: ComicUseCase = ComicUseCase(),
        comics: [ComicSummary] = [],
        status: Status = .loading
    ) {
        self.useCase = useCase
        self.comics = comics
        self.status = status
    }

    func getComicSummaries(
        for seriesID: String,
        lastID: String? = nil,
        limit: Int = 20,
        fromDataSource dataSource: DataSourceLayer = .memory
    ) {
        guard !isLoading, canLoadMore else { return }
        
        isLoading = true
        useCase.getMyComics(for: seriesID, afterID: lastID, limit: limit, fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case let .success(comics):
                for comic in comics where !self.comicsIdentifier.contains(comic.identifier) {
                    self.comics.append(comic)
                    self.comicsIdentifier.insert(comic.identifier)
                }
                self.status = .showComics
                self.canLoadMore = comics.count >= limit
            case .failure:
                self.canLoadMore = false
                guard self.comics.isEmpty else { return }
                self.status = .error(message: "Something went wrong. Please try again later ❤️")
            }
        }
    }
    
    var lastIdentifier: String? {
        comics.last?.identifier
    }
    
}
