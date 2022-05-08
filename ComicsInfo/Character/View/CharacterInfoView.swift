//
//  CharacterInfoView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 07/09/2021.
//

import SwiftUI

struct CharacterInfoView: View {
    
    @ObservedObject private var viewModel: CharacterInfoViewModel
    @State private var showBanner = AppTrackingManager.authorization
    
    init(for character: Character) {
        viewModel = CharacterInfoViewModel(from: character)
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        HStack {
                            CharacterInfoThumbnailView(
                                imageName: viewModel.thumbnail,
                                systemName: viewModel.thumbnailSystemName,
                                height: 100
                            )
                    
                            Text(viewModel.name)
                                .font(.subheadline)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .padding()
                        
                        ReactionsView(
                            types: [.share, .bookmark],
                            isInMyComics: $viewModel.isInMyCharacters,
                            isBookmarked: viewModel.isBookmarked,
                            shereMessage: viewModel.shereMessage,
                            onTapAdd: viewModel.onTapAdd,
                            onTapBookmark: viewModel.onTapBookmark
                        )
                
                        if !viewModel.realName.isEmpty {
                            HStack {
                                Text("Real Name:")
                                    .font(.subheadline)
                                Text(viewModel.realName)
                                    .font(.subheadline)
                                Spacer()
                            }
                            .padding([.trailing, .leading])
                        }
                        
                        if !viewModel.birthday.isEmpty {
                            HStack {
                                Text("Birthday:")
                                    .font(.subheadline)
                                Text(viewModel.birthday)
                                    .font(.subheadline)
                                Spacer()
                            }
                            .padding([.trailing, .leading])
                        }
                        
                        if !viewModel.description.isEmpty {
                            DescriptionView(description: viewModel.description)
                        }
                    }
                }
                if showBanner {
                    BannerView(showBanner: $showBanner, adUnitID: Environment.characterInfoADUnitID)
                }
            }
            
            if viewModel.isLoading {
                MainProgressView()
            }
        }
        .onAppear {
            viewModel.isInBookmark()
        }
        .navigationBarTitle(viewModel.name, displayMode: .inline)
    }
    
}

#if DEBUG
struct CharacterInfoView_Previews: PreviewProvider {
    
    private static let character = Character.make()
    
    static var previews: some View {
        CharacterInfoView(for: character)
    }
    
}
#endif
