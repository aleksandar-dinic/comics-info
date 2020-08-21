//
//  SeriesView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct SeriesView: View {

    @State var series: Series

    var body: some View {
        HStack {
            SeriesThumbnailView(
                imageName: series.thumbnail,
                systemName: series.thumbnailSystemName
            )

            VStack {
                Text(series.title)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .font(.subheadline)
                Text(series.startAndEndYer)
                    .frame(maxWidth: .infinity)
                    .font(.footnote)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

}

#if DEBUG
struct SeriesView_Previews: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            SeriesView(series: Series.theFlash)
                .padding()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }

    }
}
#endif
