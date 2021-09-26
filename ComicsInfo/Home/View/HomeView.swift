//
//  HomeView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 02/09/2021.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedItem) {
            makeExploreView()
            makeAccountView()
        }
    }
    
    private func makeExploreView() -> some View {
        ExploreView()
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Explore", systemImage: "bubble.left")
            }
            .tag(viewModel.exploreTag)
    }
    
    private func makeAccountView() -> some View {
        AccountView()
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Account", systemImage: "person.crop.circle.fill")
            }
            .tag(viewModel.accountTag)
    }
    
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
    
}
