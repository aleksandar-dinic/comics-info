//
//  SeriesViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import enum CIData.DataSourceLayer
import Foundation

final class SeriesViewModel: ObservableObject {

    enum Status: Equatable {
        case loading
        case error(message: String)
        case showSeries
    }

    private var useCase: SeriesUseCase
    private(set) var series: [Series]

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
        useCase: SeriesUseCase = SeriesUseCase(),
        series: [Series] = [],
        status: Status = .loading
    ) {
        self.useCase = useCase
        self.series = series
        self.status = status
    }

    func loadAllSeries(fromDataSource dataSource: CIData.DataSourceLayer = .memory) {
        guard dataSource == .network || series.isEmpty else { return }

        useCase.getAllSeries(fromDataSource: dataSource) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(series):
                self.series = series.sorted { $0.popularity < $1.popularity }
                self.status = .showSeries
            case let .failure(error):
                self.status = .error(message: error.localizedDescription)
            }
        }
    }

}
