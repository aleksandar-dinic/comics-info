//
//  ComicThumbnailView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicThumbnailView: View {

    let imageName: String
    let systemName: String
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
            .accessibility(identifier: "ComicThumbnailView")
    }

    private func thumbnailImage(for url: URL?) -> AsyncImage<Image> {
        AsyncImage(
            url: url,
            placeholder: {
                Image(systemName: systemName)
                    .resizable()
            },
            image: {
                Image(uiImage: $0)
                    .resizable()
            }
        )
    }

}

#if DEBUG
struct ComicThumbnailView_Previews: PreviewProvider {

    static var previews: some View {
        ComicThumbnailView(
            imageName: "AmazingSpiderMan1",
            systemName: "photo.on.rectangle",
            height: 155
        )
            .previewLayout(.fixed(width: 105, height: 155))
    }

}
#endif
