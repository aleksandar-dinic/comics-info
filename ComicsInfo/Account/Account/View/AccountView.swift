//
//  AccountView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 01/09/2021.
//

import SwiftUI

struct AccountView: View {
    
    @State private var showBanner = AppTrackingManager.authorization
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section() {
                        AuthView()
                    }
                    
                    Section() {
                        HStack {
                            Image(systemName: "bookmark")
                            NavigationLink("Bookmarks", destination: BookmarkView())
                        }
                    }
                    
                    Section() {
                        HStack {
                            Image(systemName: "envelope")
                            NavigationLink("Support & Feedback", destination: SupportView())
                        }
                    }
                }
                .listStyle(GroupedListStyle())

                if showBanner {
                    BannerView(
                        showBanner: $showBanner,
                        adUnitID: Environment.accountADUnitID
                    )
                }
            }
            .navigationBarTitle("Account", displayMode: .inline)
        }
        .accentColor(Color("AccentColor"))
    }
    
}

struct AccountView_Previews: PreviewProvider {
    
    static var previews: some View {
        AccountView()
    }
    
}
