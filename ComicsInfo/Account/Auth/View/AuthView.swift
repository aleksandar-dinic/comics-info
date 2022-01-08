//
//  AuthView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/12/2021.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                makeUserProfileView(for: user)
            } else {
                makeSignedInOrSignUpView()
            }
        }
        .onAppear {
            viewModel.getCurrentUser()
        }
    }
    
    private func makeSignedInOrSignUpView() -> some View {
        NavigationLink(destination: SignInOrSignUpView()) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.largeTitle)
                Text("Sign in or Sign up")
                    .font(.title2)
                Spacer()
            }
        }
    }
    
    private func makeUserProfileView(for user: User) -> some View {
        NavigationLink(destination: UserProfileView(user: user)) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.largeTitle)
                Text(viewModel.myAccount)
                    .font(.title2)
                Spacer()
            }
        }
    }
    
}

struct AuthView_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthView()
    }
    
}
