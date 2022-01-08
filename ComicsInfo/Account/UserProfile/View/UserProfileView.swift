//
//  UserProfileView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 02/09/2021.
//

import SwiftUI

struct UserProfileView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: UserProfileViewModel
    
    init(user: User) {
        viewModel = UserProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                Spacer()
            }
            .padding()
            .padding(.bottom, 20)
            
            if !viewModel.nickname.isEmpty {
                HStack {
                    Text("Nickname:")
                    Text(viewModel.nickname)
                }
            }
            
            if !viewModel.email.isEmpty {
                HStack {
                    Text("Email:")
                    Text(viewModel.email)
                }
            }
            
            if viewModel.canChangePassword {
                NavigationLink(destination: ChangePasswordView()) {
                    Text("Change Password")
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor)
                        .cornerRadius(7)
                        .padding(8)
                }
            }
            
            Spacer()
            
            Button(action: {
                viewModel.signOut {
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Sign out")
                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                .foregroundColor(.red)
                .cornerRadius(7)
            }
            .padding(8)
        }
        .padding()
    }
    
}

struct UserProfileView_Previews: PreviewProvider {
    
    static private let user = User(
        identifier: "1",
        username: "1",
        email: "email@email.com",
        nickname: "Spider-Man"
    )
    
    static var previews: some View {
        UserProfileView(user: user)
    }
    
}
