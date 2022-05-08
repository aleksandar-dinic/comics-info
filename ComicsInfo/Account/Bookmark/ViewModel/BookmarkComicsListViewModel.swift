//
//  BookmarkComicsListViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 05/08/2022.
//  Copyright © 2022 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class BookmarkComicsListViewModel: ObservableObject {

    let comicsSummary: [ComicSummary]
    
    init(comicsSummary: [ComicSummary]) {
        self.comicsSummary = comicsSummary
    }

    var isEmpty: Bool {
        comicsSummary.isEmpty
    }
    
}
