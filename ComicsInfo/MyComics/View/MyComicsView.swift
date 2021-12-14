//
//  MyComicsView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 23/10/2021.
//

import SwiftUI

struct MyComicsView: View {
    
    @ObservedObject private var viewModel: MyComicsViewModel
    
    init(viewModel: MyComicsViewModel = MyComicsViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isEmpty {
                    makeEmptyMessage()
                } else {
                    makeCharacters()
                }
            }
            .onAppear {
                viewModel.getMyCharacters()
            }
            .navigationBarTitle("My Comics")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color("AccentColor"))
    }
    
    private func makeEmptyMessage() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("You haven't added any comics to your list yet")
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
        ForEach(viewModel.myCharacters, id: \.identifier) { character in
            Section(
                header: NavigationLink(destination: CharacterInfoView(for: character)) {
                    makeCharacterView(for: character)
                }
                    .buttonStyle(PlainButtonStyle())
            ) {
                if let seriesSummaries = character.mySeries {
                    seriesList(for: character, seriesSummaries: seriesSummaries)
                }
            }
            .onAppear {
                guard viewModel.lastIdentifier == character.identifier else { return }
                viewModel.getMyCharacters(lastID: viewModel.lastIdentifier)
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
            NavigationLink(destination: MyComicsListView(character: character, seriesSummary: seriesSummary)) {
                SeriesView(seriesSummary: SeriesSummaryViewModel(from: seriesSummary))
            }
            .padding(4)
            .id("\(character.identifier)#\(seriesSummary.identifier)")
            .buttonStyle(PlainButtonStyle())
        }
    }
    
}

struct MyComicsView_Previews: PreviewProvider {
    
    static var previews: some View {
        MyComicsView()
    }
    
}
