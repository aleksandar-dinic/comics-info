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
    
    // Bookmark
    
    func getBookmarkComics(forSeriesID seriesID: String) -> [ComicSummary]? {
        getBookmarkedComics()[seriesID]
    }
    
    func addToBookmark(_ comicSummary: ComicSummary, forSeriesID seriesID: String) {
        var comics = getBookmarkedComics()
        comics[seriesID, default: []].append(comicSummary)
        do {
            let data = try JSONEncoder().encode(comics)
            defaults.set(data, forKey: Self.bookmarkKey)
        } catch {
            print(error)
        }
    }
    
    func removeFromBookmark(_ comicID: String, forSeriesID seriesID: String) {
        var comics = getBookmarkedComics()
        guard let index = comics[seriesID]?.firstIndex(where: { $0.identifier == comicID }) else { return }

        comics[seriesID]?.remove(at: index)
        do {
            let data = try JSONEncoder().encode(comics)
            defaults.set(data, forKey: Self.bookmarkKey)
        } catch {
            print(error)
        }
    }
    
    func isBookmarked(_ comicID: String, forSeriesID seriesID: String) -> Bool {
        getBookmarkedComics()[seriesID]?.contains(where: { $0.identifier == comicID }) ?? false
    }
    
    private func getBookmarkedComics() -> [String: [ComicSummary]] {
        guard let data = defaults.object(forKey: Self.bookmarkKey) as? Data else {
            return [:]
        }
        
        do {
            let bookmarkedComics = try JSONDecoder().decode([String: [ComicSummary]].self, from: data)
            return bookmarkedComics
        } catch {
            print(error)
        }
        return [:]
    }

}
