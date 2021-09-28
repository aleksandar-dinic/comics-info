//
//  CharacterView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import SwiftUI

struct CharacterView: View {
    
    private let viewModel: CharacterViewModel

    init(for character: Character) {
        viewModel = CharacterViewModel(from: character)
    }
    
    var body: some View {
        HStack {
            CharacterThumbnailView(
                imageName: viewModel.thumbnail,
                systemName: viewModel.thumbnailSystemName,
                height: 50
            )

            VStack(spacing: 8) {
                Text(viewModel.name)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .font(.footnote)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
}

#if DEBUG
struct CharacterView_Previews: PreviewProvider {
    
    static let character = Character.make()
    
    static var previews: some View {
        CharacterView(for: character)
    }

}
#endif
