//
//  ComicsListView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicsListView: View {

    private let series: Series
    @ObservedObject private var viewModel: ComicViewModel

    init(
        forSeries series: Series,
        viewModel: ComicViewModel = ComicViewModel()
    ) {
        self.series = series
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if viewModel.status == .loading {
                Text("Loading...")
                    .font(.title)
            } else {
                List(viewModel.comics, id: \.identifier) { comic in
                    NavigationLink(destination: Text(comic.description)) {
                        ComicView(series: self.series, comic: comic)
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.loadAllComics(forSeriesID: self.series.identifier)
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.errorMessage))
        }
        .navigationBarTitle("\(series.title)", displayMode: .inline)
    }

}

#if DEBUG
struct ComicsListView_Previews: PreviewProvider {

    static let series = Series(
        identifier: "1",
        popularity: 0,
        title: "Spider-Man",
        thumbnail: "",
        description: "",
        startYear: nil,
        endYear: nil,
        charactersID: ["1"]
    )

    static let viewModel = ComicViewModel(
        comics: [
            Comic.amazingSpiderMan1,
            Comic.amazingSpiderMan2,
            Comic.amazingSpiderMan3,
            Comic.amazingSpiderMan4,
            Comic.amazingSpiderMan5
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
