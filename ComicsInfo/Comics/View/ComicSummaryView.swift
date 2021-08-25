//
//  ComicSummaryView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicSummaryView: View {
    
    @State var viewModel: ComicSummaryViewModel

    var body: some View {
        HStack {
            ComicThumbnailView(
                imageName: viewModel.thumbnail,
                systemName: viewModel.thumbnailSystemName,
                height: 150
            )

            VStack {
                Spacer()
                Spacer()
                Text(viewModel.issue)
                    .frame(maxWidth: .infinity)
                    .font(.subheadline)
                Spacer()
                Text(viewModel.title)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .font(.footnote)
                Spacer()
                Text(viewModel.publishedDate)
                    .frame(maxWidth: .infinity)
                    .font(.footnote)
                Spacer()
                Spacer()
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

}

#if DEBUG
struct ComicView_Previews: PreviewProvider {
    
    static let comicSummary = ComicSummary.make()
    static let seriesSummaryViewModel = SeriesSummaryViewModel(from: SeriesSummary.make())

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            ComicSummaryView(
                viewModel: ComicSummaryViewModel(
                    for: comicSummary,
                    seriesSummaryViewModel: seriesSummaryViewModel
                )
            )
                .previewLayout(.fixed(width: 320, height: 154))
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }

    }
}
#endif
