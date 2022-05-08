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
    case myCharacters = "MyCharacters"
    case characterSummaries = "CharacterSummaries"
    case series = "Series"
    case seriesSummaries = "SeriesSummaries"
    case mySeriesSummaries = "MySeriesSummaries"
    case comics = "Comics"
    case comicSummaries = "ComicSummaries"
    case myComics = "MyComics"
    case images = "Images"
    
}

struct CharacterCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, Character>.getFromDisc(.characters) ?? Cache<String, Character>()

}

struct MyCharacterCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, MyCharacter>.getFromDisc(.myCharacters) ?? Cache<String, MyCharacter>()

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

struct MySeriesSummaryCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, [SeriesSummary]>.getFromDisc(.mySeriesSummaries) ?? Cache<String, [SeriesSummary]>()

}

struct ComicCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, Comic>.getFromDisc(.comics) ?? Cache<String, Comic>()

}

struct MyComicCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, [ComicSummary]>.getFromDisc(.myComics) ?? Cache<String, [ComicSummary]>()

}

struct ComicSummaryCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<String, [ComicSummary]>.getFromDisc(.comicSummaries) ?? Cache<String, [ComicSummary]>()

}

struct ImageCacheKey: EnvironmentKey {
    
    static let defaultValue: Cache = Cache<URL, Data>(maximumEntryCount: 10_000)
    
}
