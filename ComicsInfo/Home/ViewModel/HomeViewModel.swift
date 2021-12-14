//
//  HomeViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 02/09/2021.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var selectedItem = HomeItem.explore
    
    let exploreTag = HomeItem.explore
    let myComicsTag = HomeItem.myComics
    let accountTag = HomeItem.account
    
}
