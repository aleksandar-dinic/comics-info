//
//  CharacterView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct CharacterView: View {

    @State var viewModel: CharacterViewModel

    var body: some View {
        HStack {
            CharacterThumbnailView(
                imageName: viewModel.thumbnail,
                systemName: viewModel.thumbnailSystemName,
                height: 16
            )
            Text(viewModel.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

}

#if DEBUG
struct CharacterView_Previews: PreviewProvider {

    static let character = Character.make()
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            CharacterView(viewModel: CharacterViewModel(from: character))
                .padding()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }

    }
}
#endif
