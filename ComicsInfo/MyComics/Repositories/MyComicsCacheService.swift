//
//  MyComicsCacheService.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/2/22.
//

import Foundation

protocol MyComicsCacheService {
    
    func saveMyCharacters(_ myCharacters: [MyCharacter])
    func getAllMyCharacters() -> [MyCharacter]?
    func getMyCharacter(withID myCharacterID: String) -> MyCharacter?
    func updateMyCharacter(_ myCharacter: MyCharacter)
    func removeMyCharacter(withID myCharacterID: String)
    
    func saveMyComics(_ myComics: [ComicSummary], forSeriesID seriesID: String)
    func getAllMyComics(forSeriesID seriesID: String) -> [ComicSummary]?
    func getMyComic(withID myComicID: String, forSeriesID seriesID: String) -> ComicSummary?
    func updateMyComic(_ myComic: ComicSummary, forSeriesID seriesID: String)
    func removeMyComic(withID myComicID: String, forSeriesID seriesID: String)
    
}
