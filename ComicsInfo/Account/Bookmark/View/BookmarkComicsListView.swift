//
//  BookmarkComicsListView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 05/08/2022.
//  Copyright © 2022 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct BookmarkComicsListView: View {

    @ObservedObject private var viewModel: BookmarkComicsListViewModel
    
    private let character: Character
    private let seriesSummary: SeriesSummary
    @State private var showBanner = AppTrackingManager.authorization

    init(
        character: Character,
        seriesSummary: SeriesSummary,
        comicsSummary: [ComicSummary]
    ) {
        self.character = character
        self.seriesSummary = seriesSummary
        viewModel = BookmarkComicsListViewModel(comicsSummary: comicsSummary)
    }

    var body: some View {
        VStack(spacing: 4) {
            ScrollView {
                LazyVStack(spacing: 4) {
                    if viewModel.isEmpty {
                        Spacer()
                        makeEmptyView()
                        Spacer()
                    } else {
                        comicsList
                    }
                }
                .padding()
            }
            if showBanner {
                BannerView(showBanner: $showBanner, adUnitID: Environment.comicsListADUnitID)
            }
        }
        .navigationBarTitle(seriesSummary.title, displayMode: .inline)
    }
    
    private var comicsList: some View {
        ForEach(viewModel.comicsSummary, id: \.identifier) { comic in
            NavigationLink(
                destination: ComicInfoView(
                    viewModel: ComicInfoViewModel(
                        character: character,
                        seriesSummary: seriesSummary,
                        comicSummary: comic,
                        useCase: ComicUseCase()
                    )
                )
            ) {
                ComicSummaryView(
                    for: comic,
                    seriesTitle: seriesSummary.title
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    private func makeEmptyView() -> some View {
        VStack {
            Text("You do not have comics in this series")
                .font(.title)
            
//            Button(action: {
//                viewModel.removeSeries(withID: seriesSummary.identifier, characterID: character.identifier) {
//                    presentationMode.wrappedValue.dismiss()
//                }
//            }) {
//                Text("Remove Series")
//                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
//                .foregroundColor(Color.white)
//                .background(Color.accentColor)
//                .cornerRadius(8)
//            }
        }
    }
    
}

#if DEBUG
struct BookmarkComicsListView_Previews: PreviewProvider {
    
    static let seriesSummary = SeriesSummary.make(
        identifier: "1",
        popularity: 0,
        title: "Spider-Man",
        thumbnail: "",
        description: "",
        startYear: nil,
        endYear: nil
    )

    static var previews: some View {
        BookmarkComicsListView(
            character: .make(),
            seriesSummary: seriesSummary,
            comicsSummary: []
        )
    }

}
#endif
