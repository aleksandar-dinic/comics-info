//
//  ComicCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI
import Foundation

struct ComicCacheProvider: ComicCacheService {
    
    static private var bookmarkKey = "BookmarkComicsKey"

    private let comicCache: Cache<String, Comic>
    private let comicSummaryCache: Cache<String, [ComicSummary]>
    private let myComicCache: Cache<String, [ComicSummary]>
    private var defaults: UserDefaults

    init(
        comicCache: Cache<String, Comic> = SwiftUI.Environment(\.comicCache).wrappedValue,
        comicSummaryCache: Cache<String, [ComicSummary]> = SwiftUI.Environment(\.comicSummariesCache).wrappedValue,
        myComicCache: Cache<String, [ComicSummary]> = SwiftUI.Environment(\.myComicCache).wrappedValue,
        defaults: UserDefaults = .standard
    ) {
        self.comicCache = comicCache
        self.comicSummaryCache = comicSummaryCache
        self.myComicCache = myComicCache
        self.defaults = defaults
    }

    func getComicSummaries(
        for seriesID: String,
        afterID: String?,
        limit: Int
    ) -> [ComicSummary]? {
        guard var items = comicSummaryCache[seriesID], !items.isEmpty else { return nil }
        var start = 0
        let count = items.count

        if let afterID = afterID {
            guard let firstIndex = items.firstIndex(where: { $0.identifier == afterID }) else {
                return nil
            }
            start = firstIndex + 1
        }

        items = Array(items[start..<min(count, start+limit)])
        return !items.isEmpty ? items : nil
    }

    func save(comicSummaries: [ComicSummary], forSeriesID seriesID: String) {
        var value = [ComicSummary]()
        var keys = Set<String>()
        if let oldValue = comicSummaryCache[seriesID] {
            value = oldValue
            oldValue
                .map { $0.identifier }
                .forEach { keys.insert($0) }
        }
        
        for summary in comicSummaries where !keys.contains(summary.identifier) {
            value.append(summary)
        }
        comicSummaryCache[seriesID] = value
        try? comicSummaryCache.saveToDisc(.comicSummaries)
    }
    
    func getComic(withID comicID: String) -> Comic? {
        comicCache[comicID]
    }

    func save(comic: Comic) {
        comicCache[comic.identifier] = comic
        try? comicCache.saveToDisc(.comics)
    }
    
    // My Comics
    
    func getMyComics(forSeriesID seriesID: String) -> [ComicSummary]? {
        myComicCache[seriesID]
    }
    
    func addInMyComics(comicSummaries: [ComicSummary], forSeriesID seriesID: String) {
        var value = [ComicSummary]()
        var keys = Set<String>()
        if let oldValue = myComicCache[seriesID] {
            value = oldValue
            oldValue
                .map { $0.identifier }
                .forEach { keys.insert($0) }
        }
        
        for summary in comicSummaries where !keys.contains(summary.identifier) {
            value.append(summary)
        }
        
        myComicCache[seriesID] = value
        try? myComicCache.saveToDisc(.myComics)
    }
    
    func isInMyComics(_ comicID: String, forSeriesID seriesID: String) -> Bool {
        myComicCache[seriesID]?.contains(where: { $0.identifier == comicID }) ?? false
    }
    
    // Bookmark
    
    func getBookmarkComics() -> [Comic]? {
        var comics = [Comic]()
        for id in getBookmarkedComics() {
            guard let comic = getComic(withID: id) else { continue }
            comics.append(comic)
        }
//        comics.sort()
        return !comics.isEmpty ? comics : nil
    }
    
    func addToBookmark(_ comicID: String) {
        var comics = getBookmarkedComics()
        comics.insert(comicID)
        defaults.set(Array(comics), forKey: Self.bookmarkKey)
    }
    
    func removeFromBookmark(_ comicID: String) {
        var comics = getBookmarkedComics()
        comics.remove(comicID)
        defaults.set(Array(comics), forKey: Self.bookmarkKey)
    }
    
    func isBookmarked(withID comicID: String) -> Bool {
        getBookmarkedComics().contains(comicID)
    }
    
    private func getBookmarkedComics() -> Set<String> {
        Set(defaults.object(forKey: Self.bookmarkKey) as? [String] ?? [String]())
    }

}
