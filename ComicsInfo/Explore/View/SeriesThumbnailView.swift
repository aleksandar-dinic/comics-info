//
//  SeriesThumbnailView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct SeriesThumbnailView: View {

    var imageName: String
    var systemName: String
    let height: CGFloat

    var body: some View {
        thumbnailImage(for: URL(string: imageName))
            .aspectRatio(contentMode: .fit)
            .frame(width: height/1.5, height: height)
            .cornerRadius(8)
            .padding(1)
            .background(Color.secondary)
            .cornerRadius(10)
            .shadow(radius: 8)
    }

    private func thumbnailImage(for url: URL?) -> AsyncImage {
        AsyncImage(
            url: url,
            placeholder: {
                Image(systemName: systemName)
            },
            image: {
                Image(uiImage: $0)
                    .resizable()
            }
        )
    }

}

#if DEBUG
struct SeriesThumbnailView_Previews: PreviewProvider {

    static var previews: some View {
        SeriesThumbnailView(
            imageName: "TheFlash",
            systemName: "photo.on.rectangle",
            height: 150
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }

}
#endif
