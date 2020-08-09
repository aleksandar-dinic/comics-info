//
//  CharactersListView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct CharactersListView: View {

    @ObservedObject private var viewModel: CharacterViewModel

    init(_ viewModel: CharacterViewModel = CharacterViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.status == .loading {
                    Text("Loading...")
                        .font(.title)
                } else {
                    List(viewModel.characters, id: \.identifier) { character in
                        NavigationLink(
                            destination: Text(character.name) // SeriesListView(forCharacter: character)
                        ) {
                            CharacterView(character: character)
                        }
                    }
                }
            }
            .onAppear {
                self.viewModel.loadAllCharacters()
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text(viewModel.errorMessage))
            }
            .navigationBarTitle("Characters")
        }
    }

}

#if DEBUG
struct CharactersListView_Previews: PreviewProvider {

    static let viewModel = CharacterViewModel(
        characters: [
            Character.flash,
            Character.spiderMan,
            Character.captainAmerica,
            Character.hulk,
            Character.ironMan,
            Character.silverSurfer,
            Character.unknown
        ],
        status: .showCharacters
    )

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            CharactersListView(viewModel)
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }
    }

}
#endif
