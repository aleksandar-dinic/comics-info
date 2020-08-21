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

    var body: some View {
        thumbnailImage()
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 150)
            .cornerRadius(8)
            .padding(1)
            .background(Color.secondary)
            .cornerRadius(10)
            .shadow(radius: 8)
    }

    private func thumbnailImage() -> Image {
        guard !imageName.isEmpty else {
            return Image(systemName: systemName)
        }
        return Image(imageName)
    }

}

#if DEBUG
struct SeriesThumbnailView_Previews: PreviewProvider {

    static var previews: some View {
        SeriesThumbnailView(
            imageName: "TheFlash",
            systemName: "photo.on.rectangle"
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }

}
#endif
