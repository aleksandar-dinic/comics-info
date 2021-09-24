//
//  ExploreView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ExploreView: View {

    @ObservedObject private var viewModel: ExploreViewModel
    @State private var showAccount = false

    init(_ viewModel: ExploreViewModel = ExploreViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.status == .loading {
                    Spacer()
                    ProgressView("Loading...")
                    Spacer()
                } else {
                    exploreList
                    if viewModel.canLoadMore {
                        loadingIndicator
                    }
                }

                if viewModel.showBanner {
                    BannerView(
                        showBanner: $viewModel.showBanner,
                        adUnitID: Environment.exploreADUnitID
                    )
                }
            }
            .navigationBarTitle("Explore")
            .toolbar {
                Button(action: {
                    showAccount.toggle()
                }, label: {
                    Image(systemName: "person.crop.circle.fill")
                })
            }
        }
        .onAppear {
            viewModel.getAllCharacters()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.errorMessage))
        }
        .sheet(isPresented: $showAccount) {
            AccountView()
        }
        .accentColor(Color("AccentColor"))
    }
    
    private var exploreList: some View {
        ScrollView {
            LazyVStack(spacing: 4, pinnedViews: [.sectionHeaders]) {
                characterList
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
        }
    }
    
    private var characterList: some View {
        ForEach(viewModel.characters, id: \.identifier) { character in
            Section(
                header: NavigationLink(
                    destination: CharacterInfoView(viewModel: CharacterInfoViewModel(from: character))
                ) {
                    makeCharacterView(for: character)
                }
                .buttonStyle(PlainButtonStyle())
            ) {
                if let seriesSummaries = character.mainSeries {
                    seriesList(for: character.identifier, seriesSummaries: seriesSummaries)
                }
            }
            .onAppear {
                guard viewModel.lastIdentifier == character.identifier else { return }
                viewModel.getAllCharacters(lastID: viewModel.lastIdentifier)
            }
        }
    }
    
    private func makeCharacterView(for character: Character) -> some View {
        CharacterView(viewModel: CharacterViewModel(from: character))
            .padding(4)
            .background(Color("AccentColor"))
    }
    
    private func seriesList(for characterID: String, seriesSummaries: [SeriesSummary]) -> some View {
        ForEach(seriesSummaries, id: \.identifier) { seriesSummary in
            NavigationLink(destination: ComicsListView(forSeriesSummary: seriesSummary)) {
                SeriesView(seriesSummary: SeriesSummaryViewModel(from: seriesSummary))
            }
            .padding(4)
            .id("\(characterID)#\(seriesSummary.identifier)")
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    private var loadingIndicator: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }

}

#if DEBUG
struct ExploreView_Previews: PreviewProvider {

    static let viewModel = ExploreViewModel(
        characterUseCase: CharacterUseCase(),
        characters: [
            Character.make(identifier: "1", name: "Spider-Man"),
            Character.make(identifier: "2", name: "Flash"),
            Character.make(identifier: "3", name: "Batman")
        ],
        status: .showCharacters
    )

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            ExploreView(viewModel)
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }
    }

}
#endif
