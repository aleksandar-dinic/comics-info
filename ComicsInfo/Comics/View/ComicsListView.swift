//
//  ComicsListView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicsListView: View {

    private let seriesSummary: SeriesSummaryViewModel
    @ObservedObject private var viewModel: ComicsListViewModel
    @State private var showBanner = AppTrackingManager.authorization

    init(
        forSeriesSummary seriesSummary: SeriesSummary,
        viewModel: ComicsListViewModel = ComicsListViewModel()
    ) {
        self.seriesSummary = SeriesSummaryViewModel(from: seriesSummary)
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 4) {
            ScrollView {
                LazyVStack(spacing: 4) {
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
            if showBanner {
                BannerView(showBanner: $showBanner, adUnitID: Environment.comicsListADUnitID)
            }
        }
        .onAppear {
            viewModel.getComicSummaries(for: seriesSummary.identifier)
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.errorMessage))
        }
        .navigationBarTitle(seriesSummary.title, displayMode: .inline)
    }
    
    private var comicsList: some View {
        ForEach(viewModel.comics, id: \.identifier) { comic in
            NavigationLink(
                destination: ComicInfoView(
                    viewModel: ComicInfoViewModel(
                        useCase: viewModel.useCase,
                        comicSummary: comic,
                        seriesSummaryViewModel: seriesSummary
                    )
                )
            ) {
                ComicSummaryView(
                    viewModel: ComicSummaryViewModel(
                        for: comic,
                        seriesSummaryViewModel: seriesSummary
                    )
                )
                .onAppear {
                    guard viewModel.lastIdentifier == comic.identifier else { return }
                    viewModel.getComicSummaries(
                        for: seriesSummary.identifier,
                        lastID: viewModel.lastIdentifier
                    )
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    private var loadingIndicator: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
}

#if DEBUG
struct ComicsListView_Previews: PreviewProvider {

    static let seriesSummary = SeriesSummary.make(
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
                ComicsListView(forSeriesSummary: seriesSummary, viewModel: viewModel)
                    .previewDisplayName("\(color)")
                    .environment(\.colorScheme, color)
            }
        }
    }

}
#endif
