//
//  CharacterListView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct CharacterListView: View {

    @ObservedObject private var viewModel: CharacterListViewModel

    init(_ viewModel: CharacterListViewModel = CharacterListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            if viewModel.status == .loading {
                Text("Loading...")
                    .font(.title)
            } else {
                List(viewModel.characters, id: \.identifier) { character in
                    NavigationLink(
                        destination: Text(character.name) // SeriesListView(forCharacter: character)
                    ) {
                        CharacterView(viewModel: CharacterViewModel(from: character))
                    }
                }
                .navigationBarTitle("Characters")
            }
        }
        .onAppear {
            viewModel.loadAllCharacters()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }

}

#if DEBUG
struct CharacterListView_Previews: PreviewProvider {

    static let viewModel = CharacterListViewModel(
        characters: [
            Character.make(),
            Character.make(),
            Character.make(),
            Character.make()
        ],
        status: .showCharacters
    )

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            CharacterListView(viewModel)
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }
    }

}
#endif
