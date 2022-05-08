//
//  MyComicsViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 23/10/2021.
//

import Foundation

final class MyComicsViewModel: LoadableObject {
    
    private let useCase: MyComicsUseCase
    
    @Published private(set) var state: LoadingState<[MyCharacter]>
    @Published private(set) var myCharacters: [MyCharacter]
    
    init(
        state: LoadingState<[MyCharacter]> = .idle,
        useCase: MyComicsUseCase = MyComicsUseCase(),
        myCharacters: [MyCharacter] = []
    ) {
        self.state = state
        self.useCase = useCase
        self.myCharacters = myCharacters
    }
    
    var isEmpty: Bool {
        myCharacters.isEmpty
    }
    
    var isSignedOut: Bool {
        state.isSignedOut
    }
    
    func getMyCharacters() {
        guard !isLoading else { return }
        
        state = .loading(currentValue: myCharacters)
        useCase.getAllMyCharacters { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(myCharacters):
                self.myCharacters = myCharacters
                self.state = .loaded(myCharacters)
            case let .failure(error):
                self.myCharacters = []
                self.state = .failed(error)
            }
        }
    }
    
    var myCharactersString: String {
        "My Characters"
    }
    
}
