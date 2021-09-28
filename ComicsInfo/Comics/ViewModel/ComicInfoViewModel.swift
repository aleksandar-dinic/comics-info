//
//  ComicInfoViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 15/08/2021.
//

import Foundation

final class ComicInfoViewModel {
    
    private let useCase: ComicUseCase
    private let comicSummary: ComicSummary
    private let seriesSummaryViewModel: SeriesSummaryViewModel
    @Published private(set) var comicViewModel: ComicViewModel?
    
    init(
        useCase: ComicUseCase,
        comicSummary: ComicSummary,
        seriesSummaryViewModel: SeriesSummaryViewModel,
        comicViewModel: ComicViewModel? = nil
    ) {
        self.useCase = useCase
        self.comicSummary = comicSummary
        self.seriesSummaryViewModel = seriesSummaryViewModel
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
                    seriesSummaryViewModel: self.seriesSummaryViewModel
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
            return "\(seriesSummaryViewModel.title)"
        }
        return "\(seriesSummaryViewModel.title) #\(number)"
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
