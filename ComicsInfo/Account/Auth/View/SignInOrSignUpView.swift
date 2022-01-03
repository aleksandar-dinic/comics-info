//
//  SignInOrSignUpView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/12/2021.
//

import SwiftUI

struct SignInOrSignUpView: View {
    
    @State private var showSignIn = true
    
    var body: some View {
        Group {
            if showSignIn {
                SignInView(showen: $showSignIn.animation())
            } else {
                SignUpView(showSignIn: $showSignIn.animation())
            }
        }
    }
    
}

struct SignInOrSignUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        SignInOrSignUpView()
    }

}
