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

    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 75, height: 75)
            .cornerRadius(8)
            .padding(1)
            .background(Color.secondary)
            .cornerRadius(10)
            .shadow(radius: 8)
    }

}

#if DEBUG
struct CharacterThumbnailView_Previews: PreviewProvider {

    static var previews: some View {
        CharacterThumbnailView(imageName: "SpiderMan")
            .previewLayout(.fixed(width: 80, height: 80))
    }

}
#endif
