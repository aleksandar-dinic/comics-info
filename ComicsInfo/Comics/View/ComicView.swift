//
//  ComicView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicView: View {

    @State var series: Series
    @State var comic: Comic

    var body: some View {
        HStack {
            ComicThumbnailView(
                imageName: comic.thumbnail,
                systemName: comic.thumbnailSystemName
            )
            .frame(width: 100, height: 150)

            VStack {
                Spacer()
                Spacer()
                Text("\(series.title) \(comic.issue)")
                    .frame(maxWidth: .infinity)
                    .font(.subheadline)
                Spacer()
                Text("\"\(comic.title)\"")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .font(.footnote)
                Spacer()
                Text("(\(comic.publishedDate))")
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

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            ComicView(
                series: Series.amazingSpiderMan,
                comic: Comic.amazingSpiderMan1
            )
                .previewLayout(.fixed(width: 320, height: 154))
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }

    }
}
#endif
