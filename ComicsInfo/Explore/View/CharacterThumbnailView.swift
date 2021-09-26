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
    let height: CGFloat

    var body: some View {
        thumbnailImage(for: URL(string: imageName))
            .aspectRatio(contentMode: .fill)
            .frame(width: height, height: height)
            .cornerRadius(2)
            .shadow(radius: 8)
    }
    
    private func thumbnailImage(for url: URL?) -> AsyncImage {
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
struct CharacterThumbnailView_Previews: PreviewProvider {

    static var previews: some View {
        CharacterThumbnailView(
            imageName: "SpiderMan",
            systemName: "person.crop.circle",
            height: 20
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }

}
#endif
