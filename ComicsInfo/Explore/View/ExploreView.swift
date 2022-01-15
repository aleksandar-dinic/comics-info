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
    @StateObject private var alertController = AlertController()

    init(viewModel: ExploreViewModel = ExploreViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.status.isLoading() {
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.alertController = alertController
            viewModel.getAllCharacters()
        }
        .accentColor(Color("AccentColor"))
        .environmentObject(alertController)
        .alert(item: $alertController.info) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message),
                dismissButton: alert.dismissButton
            )
        }
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
                header: NavigationLink(destination: CharacterInfoView(for: character)) {
                    makeCharacterView(for: character)
                }
                    .buttonStyle(PlainButtonStyle())
            ) {
                if let seriesSummaries = character.mainSeries {
                    seriesList(for: character, seriesSummaries: seriesSummaries)
                }
            }
            .onAppear {
                guard viewModel.lastIdentifier == character.identifier else { return }
                viewModel.getAllCharacters(lastID: viewModel.lastIdentifier)
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
            NavigationLink(destination: ComicsListView(character: character, seriesSummary: seriesSummary)) {
                SeriesView(seriesSummary: SeriesSummaryViewModel(from: seriesSummary))
            }
            .padding(4)
            .id("\(character.identifier)#\(seriesSummary.identifier)")
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
    
    static let characters = [
        Character.make(identifier: "1", name: "Spider-Man"),
        Character.make(identifier: "2", name: "Flash"),
        Character.make(identifier: "3", name: "Batman")
    ]

    static let viewModel = ExploreViewModel(
        characterUseCase: CharacterUseCase(),
        characters: characters,
        status: .loading(currentValue: characters)
    )

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            ExploreView(viewModel: viewModel)
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }
    }

}
#endif
