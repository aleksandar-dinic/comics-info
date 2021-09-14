//
//  CharacterInfoView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 07/09/2021.
//

import SwiftUI

struct CharacterInfoView: View {
    
    @State var viewModel: CharacterInfoViewModel
    @State private var showBanner = true
    
    var body: some View {
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
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .padding()
            
                    if !viewModel.description.isEmpty {
                        DescriptionView(description: viewModel.description)
                    }
                }
            }
            if showBanner {
                BannerView(showBanner: $showBanner, adUnitID: Environment.characterInfoADUnitID)
            }
        }
        .navigationBarTitle(viewModel.name, displayMode: .inline)
    }
    
}

struct CharacterInfoView_Previews: PreviewProvider {
    
    private static let character = Character.make()
    private static let viewModel = CharacterInfoViewModel(from: character)
    
    static var previews: some View {
        CharacterInfoView(viewModel: viewModel)
    }
    
}
