//
//  MyComicsViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 23/10/2021.
//

import Foundation

final class MyComicsViewModel: ObservableObject {
    
    private let useCase: MyComicsUseCase
    
    @Published private(set) var myCharacters: [Character]
    
    init(
        useCase: MyComicsUseCase = MyComicsUseCase(),
        myCharacters: [Character] = []
    ) {
        self.useCase = useCase
        self.myCharacters = myCharacters
    }
    
    var isEmpty: Bool {
        myCharacters.isEmpty
    }
    
    func getMyCharacters(
        lastID: String? = nil,
        fields: Set<String>? = nil,
        limit: Int = 20,
        fromDataSource dataSource: DataSourceLayer = .memory
    ) {
        myCharacters = useCase.getMyCharacters() ?? []
    }
    
    var myCharactersString: String {
        "My Characters"
    }
    
    var lastIdentifier: String? {
        myCharacters.last?.identifier
    }
    
}
