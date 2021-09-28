//
//  BookmarkViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import Foundation

final class BookmarkViewModel: ObservableObject {
    
    private let useCase: BookmarkUseCase
    
    @Published private(set) var characters: [Character]
    @Published private(set) var comics: [Comic]
    @Published private(set) var isBookmarkEmpty: Bool
    
    init(
        useCase: BookmarkUseCase = BookmarkUseCase(),
        characters: [Character] = [],
        comics: [Comic] = [],
        isBookmarkEmpty: Bool = true
    ) {
        self.useCase = useCase
        self.characters = characters
        self.comics = comics
        self.isBookmarkEmpty = isBookmarkEmpty
    }
    
    func getBookmarks() {
        getCharacters()
        getComics()
    }
    
    private func getCharacters() {
        guard let characters = useCase.getBookmarkCharacters() else {
            self.characters.removeAll()
            return
        }
        isBookmarkEmpty = false
        self.characters = characters
    }
    
    private func getComics() {
        guard let comics = useCase.getBookmarkComics() else {
            self.comics.removeAll()
            return
        }
        isBookmarkEmpty = false
        self.comics = comics
    }
    
}
