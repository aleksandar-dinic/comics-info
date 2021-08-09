//
//  ComicThumbnailView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicThumbnailView: View {

    var imageName: String
    var systemName: String

    var body: some View {
        thumbnailImage()
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
            .padding(1)
            .background(Color.secondary)
            .cornerRadius(10)
            .shadow(radius: 8)
            .accessibility(identifier: "ComicThumbnailView")
    }

    private func thumbnailImage() -> Image {
        guard !imageName.isEmpty else {
            return Image(systemName: systemName)
        }
        return Image(imageName)
    }

}

#if DEBUG
struct ComicThumbnailView_Previews: PreviewProvider {

    static var previews: some View {
        ComicThumbnailView(
            imageName: "AmazingSpiderMan1",
            systemName: "photo.on.rectangle"
        )
            .previewLayout(.fixed(width: 105, height: 155))
    }

}
#endif
