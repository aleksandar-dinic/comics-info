//
//  DiscoverView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct DiscoverView: View {

    @ObservedObject private var viewModel: DiscoverViewModel

    init(_ viewModel: DiscoverViewModel = DiscoverViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            if viewModel.status == .loading {
                ProgressView {
                    Text("Loading...")
                        .font(.title)
                }
            } else {
                List {
//                    ForEach(viewModel.characters, id: \.identifier) { character in
//                        Section(header: Text(character.name)) {
                            ForEach(viewModel.series, id: \.identifier) { series in
                                NavigationLink(
                                    destination: ComicsListView(forSeries: series)
                                ) {
                                    SeriesView(series: SeriesViewModel(from: series))
                                }
//                            }
//                        }
                    }
                }
                .navigationBarTitle("Discover")
            }
        }
        .onAppear {
            viewModel.loadAllSeries()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }

}

#if DEBUG
struct DiscoverView_Previews: PreviewProvider {

    static let viewModel = DiscoverViewModel(
        series: [
            Series.make(),
            Series.make(),
            Series.make()
        ],
        status: .showSeries
    )

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            DiscoverView(viewModel)
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }
    }

}
#endif
