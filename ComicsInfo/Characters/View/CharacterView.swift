//
//  CharacterView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct CharacterView: View {

    @State var character: Character

    var body: some View {
        HStack {
            CharacterThumbnailView(imageName: character.thumbnail ?? "")

            Text(character.name)
                .frame(maxWidth: .infinity)
                .font(.subheadline)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

}

#if DEBUG
struct CharacterView_Previews: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            CharacterView(character: Character.spiderMan)
                .previewLayout(.fixed(width: 320, height: 79))
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }

    }
}
#endif
