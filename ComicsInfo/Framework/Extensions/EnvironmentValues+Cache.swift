//
//  EnvironmentValues+Cache.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 29/08/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import SwiftUI
import Foundation

extension EnvironmentValues {
    
    var characterCache: Cache<String, Character> {
        get {
            self[CharacterCacheKey.self]
        }
        set {
            self[CharacterCacheKey.self] = newValue
        }
    }
    
    var characterSummariesCache: Cache<String, [CharacterSummary]> {
        get {
            self[CharacterSummaryCacheKey.self]
        }
        set {
            self[CharacterSummaryCacheKey.self] = newValue
        }
    }
    
    var seriesCache: Cache<String, Series> {
        get {
            self[SeriesCacheKey.self]
        }
        set {
            self[SeriesCacheKey.self] = newValue
        }
    }
    
    var seriesSummariesCache: Cache<String, [SeriesSummary]> {
        get {
            self[SeriesSummaryCacheKey.self]
        }
        set {
            self[SeriesSummaryCacheKey.self] = newValue
        }
    }
    
    var comicCache: Cache<String, Comic> {
        get {
            self[ComicCacheKey.self]
        }
        set {
            self[ComicCacheKey.self] = newValue
        }
    }
    
    var comicSummariesCache: Cache<String, [ComicSummary]> {
        get {
            self[ComicSummaryCacheKey.self]
        }
        set {
            self[ComicSummaryCacheKey.self] = newValue
        }
    }
    
    var imageCache: Cache<URL, Data> {
        get {
            self[ImageCacheKey.self]
        }
        set {
            self[ImageCacheKey.self] = newValue
        }
    }
    
}
