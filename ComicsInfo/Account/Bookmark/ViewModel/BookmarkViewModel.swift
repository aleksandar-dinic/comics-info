//
//  BookmarkViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import Foundation

final class BookmarkViewModel: ObservableObject {
    
    private let useCase: BookmarkUseCase
    
    @Published private(set) var myCharacters: [MyCharacter]
    
    init(
        useCase: BookmarkUseCase = BookmarkUseCase(),
        myCharacters: [MyCharacter] = []
    ) {
        self.useCase = useCase
        self.myCharacters = myCharacters
    }
    
    var isBookmarkEmpty: Bool {
        myCharacters.isEmpty
    }
    
    func getCharacters() {
        guard let characters = useCase.getBookmarkCharacters() else {
            self.myCharacters.removeAll()
            return
        }
        self.myCharacters = characters
    }
    
    func getComics(forSeriesID seriesID: String) -> [ComicSummary]? {
        useCase.getBookmarkComics(forSeriesID: seriesID)
    }
    
}
