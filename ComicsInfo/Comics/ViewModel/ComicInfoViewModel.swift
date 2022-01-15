//
//  ComicInfoViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 15/08/2021.
//

import Foundation

final class ComicInfoViewModel {
    
    private let character: Character
    private let seriesSummary: SeriesSummary
    private let comicSummary: ComicSummary
    private let useCase: ComicUseCase
    @Published private(set) var comicViewModel: ComicViewModel?
    
    init(
        character: Character,
        seriesSummary: SeriesSummary,
        comicSummary: ComicSummary,
        useCase: ComicUseCase,
        comicViewModel: ComicViewModel? = nil
    ) {
        self.character = character
        self.seriesSummary = seriesSummary
        self.comicSummary = comicSummary
        self.useCase = useCase
        self.comicViewModel = comicViewModel
    }
    
    func loadComic(
        withID comicID: String,
        fromDataSource dataSource: DataSourceLayer = .memory
    ) {
        useCase.getComic(withID: comicID, fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(comic):
                self.comicViewModel = ComicViewModel(
                    from: comic,
                    seriesSummary: self.seriesSummary
                )
            case let .failure(error):
                print(error)
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
        if !isInMyComics() {
            useCase.addToMyComics(
                comicSummary,
                character: character,
                seriesSummary: seriesSummary
            )
        } else {
            useCase.removeFromMyComics(
                comicSummary,
                character: character,
                seriesSummary: seriesSummary
            )
        }
    }
    
    func isInMyComics() -> Bool {
        useCase.isInMyComics(
            comicSummary.identifier,
            forSeriesID: seriesSummary.identifier
        )
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
