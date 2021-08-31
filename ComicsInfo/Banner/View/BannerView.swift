//
//  BannerView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 30/08/2021.
//

import SwiftUI

struct BannerView: View {
    
    @State private var isLoading = true
    @Binding var showBanner: Bool
    let adUnitID: String
    
    var body: some View {
        HStack {
            Spacer()
            ZStack(alignment: .topTrailing) {
                GoogleBannerViewController(
                    didReceiveAd: {
                        withAnimation {
                            isLoading = false
                        }
                    }
                )
                .frame(width: 320, alignment: .center)
//                Image(systemName: "xmark.square.fill")
//                    .opacity(isLoading ? 0 : 1)
//                    .foregroundColor(.red)
//                    .background(Color.white)
//                    .onTapGesture {
//                        withAnimation {
//                            showBanner.toggle()
//                        }
//                    }
            }
            Spacer()
        }
        .frame(height: isLoading ? 0 : 50)
    }
    
}

struct BannerView_Previews: PreviewProvider {
    
    @State static var showBanner = true
    
    static var previews: some View {
        BannerView(showBanner: $showBanner, adUnitID: Environment.adUnitID)
    }
    
}
