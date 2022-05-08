//
//  MyComicsCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/2/22.
//

import SwiftUI
import Foundation

struct MyComicsCacheProvider: MyComicsCacheService {
    
    private let myCharacterCache: Cache<String, MyCharacter>
    private let myComicCache: Cache<String, [ComicSummary]>
    private var defaults: UserDefaults

    init(
        myCharacterCache: Cache<String, MyCharacter> = SwiftUI.Environment(\.myCharacterCache).wrappedValue,
        myComicCache: Cache<String, [ComicSummary]> = SwiftUI.Environment(\.myComicCache).wrappedValue,
        defaults: UserDefaults = .standard
    ) {
        self.myCharacterCache = myCharacterCache
        self.myComicCache = myComicCache
        self.defaults = defaults
    }

    // My Characters
    
    func saveMyCharacters(_ myCharacters: [MyCharacter]) {
        for var myCharacter in myCharacters {
            
            if var mySeries = myCharacterCache[myCharacter.identifier]?.mySeries {
                var dict = [String: Int]()
                for (i, el) in mySeries.enumerated() {
                    dict[el.identifier] = i
                }
                
                for series in myCharacter.mySeries ?? [] {
                    guard dict[series.identifier] == nil else { continue }
                    dict[series.identifier] = mySeries.count
                    mySeries.append(series)
                }
                myCharacter.mySeries = mySeries.sorted()
            }
            
            myCharacterCache[myCharacter.identifier] = myCharacter
        }
        try? myCharacterCache.saveToDisc(.myCharacters)
    }
    
    func getAllMyCharacters() -> [MyCharacter]? {
        myCharacterCache.values()?.sorted()
    }
    
    func getMyCharacter(withID myCharacterID: String) -> MyCharacter? {
        myCharacterCache[myCharacterID]
    }
    
    func updateMyCharacter(_ myCharacter: MyCharacter) {
        myCharacterCache[myCharacter.identifier] = myCharacter
        try? myCharacterCache.saveToDisc(.myCharacters)
    }
    
    func removeMyCharacter(withID myCharacterID: String) {
        myCharacterCache.removeValue(forKey: myCharacterID)
        try? myCharacterCache.saveToDisc(.myCharacters)
    }
    
    // My Comics
    
    func saveMyComics(_ myComics: [ComicSummary], forSeriesID seriesID: String) {
        var value = [ComicSummary]()
        var keys = Set<String>()
        if let oldValue = myComicCache[seriesID] {
            value = oldValue
            oldValue
                .map { $0.identifier }
                .forEach { keys.insert($0) }
        }
        
        for comic in myComics where !keys.contains(comic.identifier) {
            value.append(comic)
        }
        
        myComicCache[seriesID] = value
        try? myComicCache.saveToDisc(.myComics)
    }
    
    func getAllMyComics(forSeriesID seriesID: String) -> [ComicSummary]? {
        myComicCache[seriesID]?.sorted()
    }
    
    func getMyComic(withID myComicID: String, forSeriesID seriesID: String) -> ComicSummary? {
        myComicCache[seriesID]?.first(where: { $0.identifier == myComicID })
    }
    
    func updateMyComic(_ myComic: ComicSummary, forSeriesID seriesID: String) {
        guard let index = myComicCache[seriesID]?.firstIndex(where: { $0.identifier == myComic.identifier }) else {
            return
        }
        myComicCache[seriesID]?[index] = myComic
    }
    
    func removeMyComic(withID myComicID: String, forSeriesID seriesID: String) {
        guard let index = myComicCache[seriesID]?.firstIndex(where: { $0.identifier == myComicID }) else {
            return
        }
        myComicCache[seriesID]?.remove(at: index)
        
        if myComicCache[seriesID]?.isEmpty ?? false {
            myComicCache.removeValue(forKey: seriesID)
        }
        try? myComicCache.saveToDisc(.myComics)
    }
    
}
