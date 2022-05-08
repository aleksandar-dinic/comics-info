//
//  ComicInfoViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 15/08/2021.
//

import Foundation

final class ComicInfoViewModel: LoadableObject {
    
    @Published private(set) var state: LoadingState<Void>
    private let character: Character
    private let seriesSummary: SeriesSummary
    private let comicSummary: ComicSummary
    private let useCase: ComicUseCase
    @Published var isInMyComics: Bool
    @Published private(set) var comicViewModel: ComicViewModel?
    
    init(
        state: LoadingState<Void> = .idle,
        character: Character,
        seriesSummary: SeriesSummary,
        comicSummary: ComicSummary,
        useCase: ComicUseCase,
        isInMyComics: Bool = false,
        comicViewModel: ComicViewModel? = nil
    ) {
        self.state = state
        self.character = character
        self.seriesSummary = seriesSummary
        self.comicSummary = comicSummary
        self.useCase = useCase
        self.isInMyComics = isInMyComics
        self.comicViewModel = comicViewModel
    }
    
    func loadComic(
        withID comicID: String,
        fromDataSource dataSource: DataSourceLayer = .memory
    ) {
        guard !isLoading else { return }
        state = .loading(currentValue: nil)

        useCase.getComic(withID: comicID, fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(comic):
                self.isInMyComics { _ in
                    self.state = .loaded(())
                    self.comicViewModel = ComicViewModel(
                        from: comic,
                        seriesSummary: self.seriesSummary
                    )
                }
            case let .failure(error):
                self.state = .failed(error)
            }
        }
    }
    
    var identifier: String {
        comicViewModel?.identifier ?? comicSummary.identifier
    }
    
    var title: String {
        guard let title = comicViewModel?.title else {
            return "\"\(comicSummary.title)\""
        }
        return title
    }
    
    var thumbnail: String {
        comicViewModel?.thumbnail ?? comicSummary.thumbnail ?? ""
    }
    
    var description: String {
        comicViewModel?.description ?? comicSummary.description ?? ""
    }
    
    var thumbnailSystemName: String {
        "photo.on.rectangle"
    }
    
    var issue: String {
        if let issue = comicViewModel?.issue {
            return issue
        }

        guard let number = comicSummary.number else {
            return seriesSummaryTitle
        }
        return "\(seriesSummaryTitle) #\(number)"
    }
    
    private var seriesSummaryTitle: String {
        "\(seriesSummary.title)"
    }
    
    var publishedDate: String {
        if let publishedDate = comicViewModel?.publishedDate {
            return publishedDate
        }

        guard let published = comicSummary.published else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, YYY"
        return "(\(formatter.string(from: published)))"
    }
    
    func onTapAdd() {
        guard !isLoading else { return }
        state = .loading(currentValue: nil)
        
        isInMyComics() { [weak self] inMyComics in
            guard let self = self else { return }
            if inMyComics {
                self.useCase.removeFromMyComics(
                    self.comicSummary.identifier,
                    seriesID: self.seriesSummary.identifier,
                    characterID: self.character.identifier
                ) { _ in
                    self.state = .loaded(())
                    self.isInMyComics = false
                }
            } else {
                self.useCase.addToMyComics(
                    self.comicSummary,
                    seriesSummary: self.seriesSummary,
                    character: self.character
                ) { _ in
                    self.state = .loaded(())
                    self.isInMyComics = true
                }
            }
        }
    }
    
    private func isInMyComics(onComplete complete: @escaping (Bool) -> Void) {
        useCase.isInMyComics(comicSummary.identifier, forSeriesID: seriesSummary.identifier) { [weak self] result in
            guard let self = self else { return }
            do {
                try result.get()
                self.isInMyComics = true
            } catch {
                self.isInMyComics = false
            }
            complete(self.isInMyComics)
        }
    }
    
    func onTapBookmark() {
        if !isBookmarked() {
            useCase.addToBookmark(comicSummary.identifier)
        } else {
            useCase.removeFromBookmark(comicSummary.identifier)
        }
    }
    
    func isBookmarked() -> Bool {
        useCase.isBookmarked(withID: comicSummary.identifier)
    }
    
    var shereMessage: String {
        "Find more information about \(title) in the \"Comics Info\" app."
    }
    
}
