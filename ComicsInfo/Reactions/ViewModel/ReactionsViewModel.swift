//
//  ReactionsViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import SwiftUI
import Foundation

final class ReactionsViewModel: ObservableObject {
    
    private let types: [ReactionType]
    @Published private(set) var isHeartSelected: Bool
    @Published private(set) var isInMyComics: Bool
    @Published private(set) var isBookmarked: Bool
    private let shareSheet: ShareSheet
    
    init(
        types: [ReactionType] = ReactionType.allCases,
        isHeartSelected: Bool = false,
        isInMyComics: Bool = false,
        isBookmarked: Bool = false,
        shareSheet: ShareSheet = ShareSheet()
    ) {
        self.types = types
        self.isHeartSelected = isHeartSelected
        self.isInMyComics = isInMyComics
        self.isBookmarked = isBookmarked
        self.shareSheet = shareSheet
    }
    
    func isAvailable(_ type: ReactionType) -> Bool {
        types.contains(type)
    }
    
    // Heart
    
    func onTapHeart() {
        isHeartSelected.toggle()
    }
    
    var heartImage: Image {
        isHeartSelected ? Image(systemName: "heart.fill") : Image(systemName: "heart")
    }
    
    // Add
    
    func onTapAdd() {
        isInMyComics.toggle()
    }
    
    var addImage: Image {
        isInMyComics ? Image(systemName: "minus.circle") : Image(systemName: "plus.circle")
    }
    
    // Bookmark
    
    func onTapBookmark() {
        isBookmarked.toggle()
    }
    
    var bookmarkImage: Image {
        isBookmarked ? Image(systemName: "bookmark.fill") : Image(systemName: "bookmark")
    }
    
    func actionSheet(_ message: String) {
        shareSheet.actionSheet([message])
    }
    
}
