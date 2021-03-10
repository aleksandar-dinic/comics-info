//
//  ComicsListView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicsListView: View {

    private let series: SeriesPresenter
    @ObservedObject private var viewModel: ComicViewModel

    init(
        forSeries series: Series,
        viewModel: ComicViewModel = ComicViewModel()
    ) {
        self.series = SeriesPresenter(from: series)
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if viewModel.status == .loading {
                Text("Loading...")
                    .font(.title)
            } else {
                List(viewModel.comics, id: \.identifier) { comic in
                    NavigationLink(destination: ComicInfoView(series: series, comic: ComicPresenter(from: comic))) {
                        ComicView(series: series, comic: ComicPresenter(from: comic))
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadAllComics()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.errorMessage))
        }
        .navigationBarTitle("\(series.title)", displayMode: .inline)
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

    static let viewModel = ComicViewModel(
        comics: [
            Comic.make(),
            Comic.make(),
            Comic.make()
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