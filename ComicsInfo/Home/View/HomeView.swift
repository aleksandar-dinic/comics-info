//
//  HomeView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 02/09/2021.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = HomeViewModel()
    private let exploreViewModel = ExploreViewModel()
    private let myComicsViewModel = MyComicsViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedItem) {
            makeExploreView()
            makeMyComicsView()
            makeAccountView()
        }
    }
    
    private func makeExploreView() -> some View {
        ExploreView(viewModel: exploreViewModel)
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Explore", systemImage: "bubble.left")
            }
            .tag(viewModel.exploreTag)
    }
    
    private func makeMyComicsView() -> some View {
        MyComicsView(viewModel: myComicsViewModel)
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("My Comics", systemImage: "bubble.left.and.bubble.right")
            }
            .tag(viewModel.myComicsTag)
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
