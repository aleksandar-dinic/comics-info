//
//  AccountView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 01/09/2021.
//

import SwiftUI

struct AccountView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    @State private var showBanner = AppTrackingManager.authorization
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section() {
                        UserProfileView()
                    }
                    
                    Section() {
                        NavigationLink("Support & Feedback", destination: SupportView())
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
            .toolbar {
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .accentColor(Color("AccentColor"))
    }
    
}

struct AccountView_Previews: PreviewProvider {
    
    static var previews: some View {
        AccountView()
    }
    
}
