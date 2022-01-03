//
//  MainProgressView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 27/12/2021.
//

import SwiftUI

struct MainProgressView: View {
    
    private let title: String
    
    init(_ title: String = "Please wait...") {
        self.title = title
    }
    
    var body: some View {
        ProgressView(title)
            .padding()
            .shadow(radius: 10)
            .background(Color.secondary)
            .foregroundColor(.primary)
            .cornerRadius(8)
    }
    
}

struct MainProgressView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainProgressView("Loading...")
    }
    
}
