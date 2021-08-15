//
//  ComicInfoView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicInfoView: View {

    let viewModel: ComicInfoViewModel

    var body: some View {
        ScrollView {
            LazyVStack {
                HStack {
                    ComicThumbnailView(
                        imageName: viewModel.thumbnail,
                        systemName: viewModel.thumbnailSystemName
                    )
                    .frame(height: 250)

                    VStack(spacing: 4) {
                        Spacer()
                        Text(viewModel.title)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .accessibility(identifier: "Title")
                        Spacer()
                        Text(viewModel.publishedDate)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .accessibility(identifier: "PublishedDate")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .frame(height: 250)
                .padding()

                if !viewModel.description.isEmpty {
                    DescriptionView(description: viewModel.description)
                }
            }
        }
        .onAppear {
            viewModel.loadComic(withID: viewModel.identifier)
        }
        .navigationBarTitle(viewModel.issue, displayMode: .inline)
    }

}

#if DEBUG
struct ComicInfoView_Previews: PreviewProvider {
    
    static let useCase = ComicUseCase()
    static let comicSummary = ComicSummary.make()
    static let series = Series.make()

    static var previews: some View {
        NavigationView {
            ForEach(ColorScheme.allCases, id: \.self) { color in
                ComicInfoView(
                    viewModel:
                        ComicInfoViewModel(
                            useCase: useCase,
                            comicSummary: comicSummary,
                            seriesViewModel: SeriesViewModel(from: series)
                        )
                )
                    .previewDisplayName("\(color)")
                    .environment(\.colorScheme, color)
            }
        }
    }

}
#endif
