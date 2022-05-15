//
//  ComicInfoView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct ComicInfoView: View {

    @SwiftUI.Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: ComicInfoViewModel
    @State private var showBanner = AppTrackingManager.authorization

    init(
        character: Character,
        seriesSummary: SeriesSummary,
        comicSummary: ComicSummary,
        useCase: ComicUseCase = ComicUseCase(),
        isInMyComics: Bool = false
    ) {
        viewModel = ComicInfoViewModel(
            character: character,
            seriesSummary: seriesSummary,
            comicSummary: comicSummary,
            useCase: useCase,
            isInMyComics: isInMyComics
        )
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        HStack {
                            ComicThumbnailView(
                                imageName: viewModel.thumbnail,
                                systemName: viewModel.thumbnailSystemName,
                                height: 250
                            )

                            VStack(spacing: 4) {
                                Spacer()
                                Text(viewModel.title)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                                    .accessibility(identifier: "Title")
                                Spacer()
                                Text(viewModel.publishedDate)
                                    .font(.caption)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .accessibility(identifier: "PublishedDate")
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .frame(height: 250)
                        .padding()
                        
                        ReactionsView(
                            isInMyComics: $viewModel.isInMyComics,
                            isBookmarked: viewModel.isBookmarked(),
                            shereMessage: viewModel.shereMessage,
                            onTapAdd: viewModel.onTapAdd,
                            onTapBookmark: viewModel.onTapBookmark
                        )
                        
                        if !viewModel.description.isEmpty {
                            DescriptionView(description: viewModel.description)
                        }
                    }
                }
                if showBanner {
                    BannerView(showBanner: $showBanner, adUnitID: Environment.comicInfoADUnitID)
                }
            }
            
            if viewModel.isLoading {
                MainProgressView()
            }
        }
        .onAppear {
            viewModel.loadComic(withID: viewModel.identifier)
        }
        .navigationBarTitle(viewModel.issue, displayMode: .inline)
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(
                title: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

}

#if DEBUG
struct ComicInfoView_Previews: PreviewProvider {
    
    private static let character = Character.make()
    private static let seriesSummary = SeriesSummary.make()
    private static let comicSummary = ComicSummary.make()

    static var previews: some View {
        NavigationView {
            ForEach(ColorScheme.allCases, id: \.self) { color in
                ComicInfoView(
                    character: character,
                    seriesSummary: seriesSummary,
                    comicSummary: comicSummary
                )
                    .previewDisplayName("\(color)")
                    .environment(\.colorScheme, color)
            }
        }
    }

}
#endif
