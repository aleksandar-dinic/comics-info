//
//  ComicsListView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicsListView: View {

    private let series: SeriesViewModel
    @ObservedObject private var viewModel: ComicsListViewModel

    init(
        forSeries series: Series,
        viewModel: ComicsListViewModel = ComicsListViewModel()
    ) {
        self.series = SeriesViewModel(from: series)
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                if viewModel.status == .loading {
                    Spacer()
                    ProgressView("Loading...")
                    Spacer()
                } else {
                    comicsList
                    if viewModel.canLoadMore {
                        loadingIndicator
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.loadAllComics(for: series.identifier)
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.errorMessage))
        }
        .navigationBarTitle(series.title, displayMode: .inline)
    }
    
    private var comicsList: some View {
        ForEach(viewModel.comics, id: \.identifier) { comic in
            NavigationLink(
                destination: ComicInfoView(
                    viewModel: ComicInfoViewModel(
                        useCase: viewModel.useCase,
                        comicSummary: comic,
                        seriesViewModel: series
                    )
                )
            ) {
                ComicSummaryView(
                    viewModel: ComicSummaryViewModel(
                        for: comic,
                        seriesViewModel: series
                    )
                )
            }
        }
    }

    private var loadingIndicator: some View {
        HStack {
            Spacer()
            ProgressView()
                .onAppear {
                    viewModel.loadAllComics(
                        for: series.identifier,
                        lastID: viewModel.lastIdentifier
                    )
                }
            Spacer()
        }
    }
    
}

#if DEBUG
struct ComicsListView_Previews: PreviewProvider {

    static let series = Series.make(
        identifier: "1",
        popularity: 0,
        title: "Spider-Man",
        thumbnail: "",
        description: "",
        startYear: nil,
        endYear: nil
    )

    static let viewModel = ComicsListViewModel(
        comics: [
            ComicSummary.make(),
            ComicSummary.make(),
            ComicSummary.make()
        ],
        status: .showComics
    )

    static var previews: some View {
        NavigationView {
            ForEach(ColorScheme.allCases, id: \.self) { color in
                ComicsListView(forSeries: series, viewModel: viewModel)
                    .previewDisplayName("\(color)")
                    .environment(\.colorScheme, color)
            }
        }
    }

}
#endif
