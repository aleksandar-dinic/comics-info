//
//  MyComicsListView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 14/12/2021.
//

import SwiftUI

struct MyComicsListView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode

    private let character: Character
    private let seriesSummary: SeriesSummary
    @ObservedObject private var viewModel: MyComicsListViewModel
    @State private var showBanner = AppTrackingManager.authorization

    init(
        character: Character,
        seriesSummary: SeriesSummary,
        viewModel: MyComicsListViewModel = MyComicsListViewModel()
    ) {
        self.character = character
        self.seriesSummary = seriesSummary
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 4) {
            ScrollView {
                LazyVStack(spacing: 4) {
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView("Loading...")
                        Spacer()
                    } else if viewModel.isEmpty {
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
        .onAppear {
            viewModel.getComicSummaries(for: seriesSummary.identifier)
        }
        .navigationBarTitle(seriesSummary.title, displayMode: .inline)
    }
    
    private var comicsList: some View {
        ForEach(viewModel.comics, id: \.identifier) { comic in
            NavigationLink(
                destination: ComicInfoView(
                    viewModel: ComicInfoViewModel(
                        character: character,
                        seriesSummary: seriesSummary,
                        comicSummary: comic,
                        useCase: viewModel.useCase
                    )
                )
            ) {
                ComicSummaryView(
                    for: comic,
                    seriesTitle: seriesSummary.title
                )
//                .onAppear {
//                    guard viewModel.lastIdentifier == comic.identifier else { return }
//                    viewModel.getComicSummaries(for: seriesSummary.identifier)
//                }
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

    private var loadingIndicator: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
}

#if DEBUG
struct MyComicsListView_Previews: PreviewProvider {

    private static let character = Character.make()
    
    static let seriesSummary = SeriesSummary.make(
        identifier: "1",
        popularity: 0,
        title: "Spider-Man",
        thumbnail: "",
        description: "",
        startYear: nil,
        endYear: nil
    )

    static let viewModel = MyComicsListViewModel(
        comics: [
            ComicSummary.make(),
            ComicSummary.make(),
            ComicSummary.make()
        ]
    )

    static var previews: some View {
        NavigationView {
            ForEach(ColorScheme.allCases, id: \.self) { color in
                MyComicsListView(
                    character: character,
                    seriesSummary: seriesSummary,
                    viewModel: viewModel
                )
                    .previewDisplayName("\(color)")
                    .environment(\.colorScheme, color)
            }
        }
    }

}
#endif
