//
//  CharacterThumbnailView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct CharacterThumbnailView: View {

    var imageName: String
    var systemName: String

    var body: some View {
        thumbnailImage()
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 75, height: 75)
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
struct CharacterThumbnailView_Previews: PreviewProvider {

    static var previews: some View {
        CharacterThumbnailView(
            imageName: "SpiderMan",
            systemName: "person.crop.circle"
        )
            .previewLayout(.fixed(width: 80, height: 80))
    }

}
#endif
