//
//  SeriesView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct SeriesView: View {

    @State var seriesSummary: SeriesSummaryViewModel

    var body: some View {
        HStack {
            SeriesThumbnailView(
                imageName: seriesSummary.thumbnail,
                systemName: seriesSummary.thumbnailSystemName,
                height: 150
            )

            VStack(spacing: 8) {
                Text(seriesSummary.title)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                Text(seriesSummary.startEndYear)
                    .frame(maxWidth: .infinity)
                    .font(.footnote)
            }

            Spacer()
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

}

#if DEBUG
struct SeriesView_Previews: PreviewProvider {

    static let seriesSummary = SeriesSummary.make()
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            SeriesView(seriesSummary: SeriesSummaryViewModel(from: seriesSummary))
                .padding()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }

    }
}
#endif
