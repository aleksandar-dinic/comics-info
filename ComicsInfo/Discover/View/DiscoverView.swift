//
//  DiscoverView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct DiscoverView: View {

    @ObservedObject private var viewModel: DiscoverViewModel
    @State private var showBanner = true

    init(_ viewModel: DiscoverViewModel = DiscoverViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 4) {
                        if viewModel.status == .loading {
                            Spacer()
                            ProgressView("Loading...")
                            Spacer()
                        } else {
                            discoverList
                            if viewModel.canLoadMore {
                                loadingIndicator
                            }
                        }
                    }
                }
                if showBanner {
                    BannerView(showBanner: $showBanner, adUnitID: Environment.adUnitID)
                }
            }
            
        }
        .onAppear {
            viewModel.getAllCharacters()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }
    
    private var discoverList: some View {
        ScrollView {
            LazyVStack {
                characterList
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
        }
        .navigationBarTitle("Discover")
    }
    
    private var characterList: some View {
        ForEach(viewModel.characters, id: \.identifier) { character in
            Section(
                header:
                    makeCharacterView(for: character)
                        .padding(4)
                    .frame(idealHeight: 16, maxHeight: 20)
            ) {
                if let seriesSummaries = character.series {
                    seriesList(for: character.identifier, seriesSummaries: seriesSummaries)
                }
            }
            .onAppear {
                guard viewModel.lastIdentifier == character.identifier else { return }
                viewModel.getAllCharacters(lastID: viewModel.lastIdentifier)
            }
        }
    }
    
    private func makeCharacterView(for character: Character) -> CharacterView {
        CharacterView(viewModel: CharacterViewModel(from: character))
    }
    
    private func seriesList(for characterID: String, seriesSummaries: [SeriesSummary]) -> some View {
        ForEach(seriesSummaries, id: \.identifier) { seriesSummary in
            NavigationLink(destination: ComicsListView(forSeriesSummary: seriesSummary)) {
                SeriesView(seriesSummary: SeriesSummaryViewModel(from: seriesSummary))
            }
            .id("\(characterID)#\(seriesSummary.identifier)")
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
struct DiscoverView_Previews: PreviewProvider {

    static let viewModel = DiscoverViewModel(
        characterUseCase: CharacterUseCase(),
        seriesUseCase: SeriesUseCase(),
        characters: [
            Character.make(identifier: "1", name: "Spider-Man"),
            Character.make(identifier: "2", name: "Flash"),
            Character.make(identifier: "3", name: "Batman")
        ],
        status: .showCharacters
    )

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { color in
            DiscoverView(viewModel)
                .previewDisplayName("\(color)")
                .environment(\.colorScheme, color)
        }
    }

}
#endif
