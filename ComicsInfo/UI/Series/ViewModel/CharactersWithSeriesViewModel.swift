//
//  CharactersWithSeriesViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 04/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import enum CIData.DataSourceLayer
import Foundation

final class CharactersWithSeriesViewModel: ObservableObject {

    enum Status: Equatable {
        case loading
        case error(message: String)
        case showSeries
    }

    private var charactersWithSeriesUseCase: CharactersWithSeriesUseCaseAdapter
    private(set) var characters: [Character]

    @Published private(set) var status: Status {
        didSet {
            switch status {
            case let .error(message):
                showError = true
                errorMessage = message
            default:
                showError = false
                errorMessage = ""
            }
        }
    }
    @Published var showError: Bool = false
    private(set) var errorMessage: String = ""

    init(
        charactersWithSeriesUseCase: CharactersWithSeriesUseCaseAdapter = CharactersWithSeriesUseCaseAdapter(),
        characters: [Character] = [],
        status: Status = .loading
    ) {
        self.charactersWithSeriesUseCase = charactersWithSeriesUseCase
        self.characters = characters
        self.status = status
    }

    func loadAllSeries(fromDataSource dataSource: CIData.DataSourceLayer = .memory) {
        guard dataSource == .network || characters.isEmpty else { return }

        charactersWithSeriesUseCase.getAllCharactersWithSeries(fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(characters):
                self.characters = characters.sorted { $0.popularity < $1.popularity }
                self.status = .showSeries
            case let .failure(error):
                self.status = .error(message: error.localizedDescription)
            }
        }
    }

}
