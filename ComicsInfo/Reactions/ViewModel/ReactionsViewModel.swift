//
//  ReactionsViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import SwiftUI
import Foundation

final class ReactionsViewModel: ObservableObject {
    
    @Published private(set) var isHeartSelected: Bool
    @Published private(set) var isBookmarked: Bool
    private let shareSheet: ShareSheet
    
    init(
        isHeartSelected: Bool = false,
        isBookmarked: Bool = false,
        shareSheet: ShareSheet = ShareSheet()
    ) {
        self.isHeartSelected = isHeartSelected
        self.isBookmarked = isBookmarked
        self.shareSheet = shareSheet
    }
    
    func onTapHeart() {
        isHeartSelected.toggle()
    }
    
    var heartImage: Image {
        isHeartSelected ? Image(systemName: "heart.fill") : Image(systemName: "heart")
    }
    
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
