//
//  ComicInfoView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicInfoView: View {

    let series: Series
    let comic: Comic

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    ComicThumbnailView(
                        imageName: comic.thumbnail,
                        systemName: comic.thumbnailSystemName
                    )
                    .frame(height: 250)

                    VStack(spacing: 4) {
                        Spacer()
                        Text(comic.title)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .accessibility(identifier: "Title")
                        Spacer()
                        Text(comic.publishedDate)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .accessibility(identifier: "PublishedDate")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .frame(height: 250)
                .padding()

                DescriptionView(description: comic.description)
                Spacer()
            }
        }
        .navigationBarTitle("\(series.title) \(comic.issue)", displayMode: .inline)
    }

}

#if DEBUG
struct ComicInfoView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            ForEach(ColorScheme.allCases, id: \.self) { color in
                ComicInfoView(
                    series: Series.amazingSpiderMan,
                    comic: Comic.amazingSpiderMan4
                )
                    .previewDisplayName("\(color)")
                    .environment(\.colorScheme, color)
            }
        }
    }

}
#endif
