//
//  UserProfileView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 02/09/2021.
//

import SwiftUI

struct UserProfileView: View {
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.largeTitle)
            Text("Hi, 🖖")
                .font(.largeTitle)
            Spacer()
        }
    }
    
}

struct UserProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        UserProfileView()
    }
    
}
