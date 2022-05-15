//
//  MyComicsUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 31/10/2021.
//

import Foundation

final class MyComicsUseCase: MyComicsRepositoryFactory {
    
    private lazy var myComicsRepository = makeMyComicsRepository()
    private lazy var authUseCase = AuthUseCase()
    
    let myComicsAPIService: MyComicsAPIService
    let myComicsCacheService: MyComicsCacheService
    
    init(
        myComicsAPIService: MyComicsAPIService = MyComicsAPIProvider(),
        myComicsCacheService: MyComicsCacheService = MyComicsCacheProvider()
    ) {
        self.myComicsAPIService = myComicsAPIService
        self.myComicsCacheService = myComicsCacheService
    }
    
    // My Characters
    
    func addToMyCharacters(
        _ myCharacter: MyCharacter,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            do {
                let token = try result.get()
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.myComicsRepository.createMyCharacter(myCharacter, token: token) { result in
                        DispatchQueue.main.async {
                            complete(result)
                        }
                    }
                }
            } catch {
                complete(.failure(error))
            }
        }
    }
 
    func getAllMyCharacters(
        onComplete complete: @escaping (Result<[MyCharacter], Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            do {
                let token = try result.get()
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.myComicsRepository.getAllMyCharacters(token: token) { result in
                        DispatchQueue.main.async {
                            complete(result)
                        }
                    }
                }
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    func getMyCharacter(
        withID myCharacterID: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            do {
                let token = try result.get()
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.myComicsRepository.getMyCharacter(withID: myCharacterID, token: token) { result in
                        DispatchQueue.main.async {
                            complete(result)
                        }
                    }
                }
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    func updateMyCharacter(
        _ myCharacter: MyCharacter,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            do {
                let token = try result.get()
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.myComicsRepository.updateMyCharacter(myCharacter, token: token) { result in
                        DispatchQueue.main.async {
                            complete(result)
                        }
                    }
                }
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    func removeMyCharacter(
        withID myCharacterID: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            do {
                let token = try result.get()
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.myComicsRepository.deleteMyCharacter(withID: myCharacterID, token: token) { result in
                        DispatchQueue.main.async {
                            complete(result)
                        }
                    }
                }
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    // My Series
    
    func removeMySeries(
        withID mySeriesID: String,
        characterID: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        getMyCharacter(withID: characterID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case var .success(myCharacter):
                myCharacter.removeMySeries(withID: mySeriesID)
                self.updateMyCharacter(myCharacter) { myCharacterResult in
                    switch myCharacterResult {
                    case .success:
                        complete(.success(()))
                    case let .failure(error):
                        complete(.failure(error))
                    }
                }
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    
    // My Comics
    
    func createMyComic(
        _ myComic: ComicSummary,
        seriesSummary: SeriesSummary,
        character: Character,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        let myCharacter = MyCharacter(from: character, mySeries: [seriesSummary])
        updateMyCharacter(myCharacter) { [weak self] result in
            guard let self = self else { return }
            do {
                _ = try result.get()
                self.createMyComic(myComic, seriesID: seriesSummary.identifier, onComplete: complete)
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    private func createMyComic(
        _ myComic: ComicSummary,
        seriesID: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            do {
                let token = try result.get()
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.myComicsRepository.createMyComic(myComic, seriesID: seriesID, token: token) { result in
                        DispatchQueue.main.async {
                            complete(result)
                        }
                    }
                }
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    func getMyComics(
        forSeriesID seriesID: String,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            do {
                let token = try result.get()
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.myComicsRepository.getMyComics(forSeriesID: seriesID, token: token) { result in
                        DispatchQueue.main.async {
                            complete(result)
                        }
                    }
                }
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    func getMyComic(
        withID comicID: String,
        forSeriesID seriesID: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            do {
                let token = try result.get()
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.myComicsRepository.getMyComic(withID: comicID, forSeriesID: seriesID, token: token) { result in
                        DispatchQueue.main.async {
                            complete(result)
                        }
                    }
                }
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    func deleteMyComic(
        withID comicID: String,
        characterID: String,
        seriesID: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            do {
                let token = try result.get()
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.myComicsRepository.deleteMyComic(withID: comicID, characterID: characterID, seriesID: seriesID, token: token) { result in
                        DispatchQueue.main.async {
                            complete(result)
                        }
                    }
                }
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    // User
    func isUserSignedIn() -> Bool {
        authUseCase.getCurrentUser() != nil
    }
    
}
