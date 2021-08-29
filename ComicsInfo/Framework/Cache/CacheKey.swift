//
//  CacheKey.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 15/08/2021.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import UIKit
import SwiftUI

enum CacheKey: String {
    
    case characters = "Characters"
    case characterSummaries = "CharacterSummaries"
    case series = "Series"
    case seriesSummaries = "SeriesSummaries"
    case comics = "Comics"
    case comicSummaries = "ComicSummaries"
    case images = "Images"
    
}

struct CharacterCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, Character>.getFromDisc(.characters) ?? Cache<String, Character>()

}

struct CharacterSummaryCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, [CharacterSummary]>.getFromDisc(.characterSummaries) ?? Cache<String, [CharacterSummary]>()

}

struct SeriesCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, Series>.getFromDisc(.series) ?? Cache<String, Series>()

}

struct SeriesSummaryCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, [SeriesSummary]>.getFromDisc(.seriesSummaries) ?? Cache<String, [SeriesSummary]>()

}

struct ComicCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, Comic>.getFromDisc(.comics) ?? Cache<String, Comic>()

}

struct ComicSummaryCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, [ComicSummary]>.getFromDisc(.comicSummaries) ?? Cache<String, [ComicSummary]>()

}

struct ImageCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<URL, Data>.getFromDisc(.images) ?? Cache<URL, Data>()
    
}
