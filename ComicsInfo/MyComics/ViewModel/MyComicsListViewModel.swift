//
//  MyComicsListViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 14/12/2021.
//

import Foundation

final class MyComicsListViewModel: LoadableObject {

    @Published private(set) var state: LoadingState<[ComicSummary]>
    private(set) var useCase: ComicUseCase
    private(set) var comics: [ComicSummary]
    private var comicsIdentifier = Set<String>()

    init(
        state: LoadingState<[ComicSummary]> = .idle,
        useCase: ComicUseCase = ComicUseCase(),
        comics: [ComicSummary] = []
    ) {
        self.state = state
        self.useCase = useCase
        self.comics = comics
    }

    func getComicSummaries(for seriesID: String) {
        guard !isLoading else { return }
        state = .loading(currentValue: comics)
        
        useCase.getMyComics(for: seriesID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(comics):
                for comic in comics where !self.comicsIdentifier.contains(comic.identifier) {
                    self.comics.append(comic)
                    self.comicsIdentifier.insert(comic.identifier)
                }
                self.state = .loaded(self.comics)
            case let .failure(error):
                guard self.comics.isEmpty else {
                    self.comics.removeAll()
                    self.comicsIdentifier.removeAll()
                    self.state = .loaded([])
                    return
                }
                self.state = .failed(error)
            }
        }
    }
    
    var lastIdentifier: String? {
        comics.last?.identifier
    }
    
    var isEmpty: Bool {
        comics.isEmpty
    }
    
    func removeSeries(
        withID seriesID: String,
        characterID: String,
        onComplete complete: @escaping () -> Void
    ) {
        guard !isLoading else { return }
        state = .loading(currentValue: comics)
        
        useCase.removeMySeries(withID: seriesID, characterID: characterID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.state = .idle
                complete()
            case let .failure(error):
                self.state = .failed(error)
            }
        }
    }
    
}
