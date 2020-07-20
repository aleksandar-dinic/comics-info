//
//  SeriesListView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct SeriesListView: View {

    private let character: Character
    @ObservedObject private var viewModel: SeriesViewModel

    init(
        forCharacter character: Character,
        viewModel: SeriesViewModel = SeriesViewModel()
    ) {
        self.character = character
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if viewModel.status == .loading {
                Text("Loading...")
                    .font(.title)
            } else {
                List(viewModel.series, id: \.identifier) { series in
                    NavigationLink(destination: Text(series.description)) {
                        Text(series.title)
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.loadSeries(forCharacterID: self.character.identifier)
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.errorMessage))
        }
        .navigationBarTitle("\(character.name)", displayMode: .inline)
    }

}

#if DEBUG
struct SeriesListView_Previews: PreviewProvider {

    static let character = Character(
        identifier: "1",
        popularity: 0,
        name: "Flash",
        thumbnail: "Flash",
        description: ""
    )
    static let viewModel = SeriesViewModel(
        series: [
            Series.theFlash,
            Series.theFlashVol2,
            Series.theFlashVol3,
            Series.amazingSpiderMan,
            Series.peterParkerTheSpectacularSpiderMan,
            Series.webOfSpiderMan,
            Series.theSpectacularSpiderMan,
            Series.amazingSpiderManVol5
        ],
        status: .showSeries
    )

    static var previews: some View {
        NavigationView {
            ForEach(ColorScheme.allCases, id: \.self) { color in
                SeriesListView(forCharacter: character, viewModel: viewModel)
                    .previewDisplayName("\(color)")
                    .environment(\.colorScheme, color)
            }
        }
    }

}
#endif
