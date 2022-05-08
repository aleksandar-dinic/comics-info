//
//  BookmarkView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import SwiftUI

struct BookmarkView: View {
    
    @ObservedObject private var viewModel: BookmarkViewModel
    
    init(_ viewModel: BookmarkViewModel = BookmarkViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.isBookmarkEmpty {
                makeEmptyMessage()
            } else {
                makeCharacters()
            }
        }
        .onAppear {
            viewModel.getCharacters()
        }
        .navigationBarTitle("Bookmarks", displayMode: .inline)
    }
    
    private func makeEmptyMessage() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("You haven't added any items to your Bookmarks yet")
                .font(.title)
            Text("When you do, they will show up here.")
                .font(.title3)
        }
        .padding()
    }
    
    private func makeCharacters() -> some View {
        ScrollView {
            LazyVStack(spacing: 4, pinnedViews: [.sectionHeaders]) {
                characterList
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
        }
    }
    
    private var characterList: some View {
        ForEach(viewModel.myCharacters, id: \.identifier) { myCharacter in
            Section(
                header: NavigationLink(destination: CharacterInfoView(for: Character(from: myCharacter))) {
                    makeCharacterView(for: Character(from: myCharacter))
                }
                    .buttonStyle(PlainButtonStyle())
            ) {
                if let seriesSummaries = myCharacter.mySeries {
                    seriesList(for: Character(from: myCharacter), seriesSummaries: seriesSummaries)
                }
            }
        }
    }
    
    private func makeCharacterView(for character: Character) -> some View {
        CharacterHeaderView(viewModel: CharacterViewModel(from: character))
            .padding(4)
            .background(Color("AccentColor"))
    }
    
    private func seriesList(for character: Character, seriesSummaries: [SeriesSummary]) -> some View {
        ForEach(seriesSummaries, id: \.identifier) { seriesSummary in
            NavigationLink(
                destination:
                    BookmarkComicsListView(
                        character: character,
                        seriesSummary: seriesSummary,
                        comicsSummary: viewModel.getComics(forSeriesID: seriesSummary.identifier) ?? []
                    )
            ) {
                SeriesView(seriesSummary: SeriesSummaryViewModel(from: seriesSummary))
            }
            .padding(4)
            .id("\(character.identifier)#\(seriesSummary.identifier)")
            .buttonStyle(PlainButtonStyle())
        }
    }
    
}

struct BookmarkView_Previews: PreviewProvider {
    
    static var previews: some View {
        BookmarkView()
    }
    
}
