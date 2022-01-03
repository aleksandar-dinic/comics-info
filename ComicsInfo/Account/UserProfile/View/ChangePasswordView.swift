//
//  ChangePasswordView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 23/12/2021.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = ChangePasswordViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Change Password")
                    .font(.largeTitle)
                
                makeOldPasswordInputView()
                makeNewPasswordInputView()
                makeConfirmButton()
                
                Spacer()
            }
            
            if viewModel.isLoading {
                MainProgressView()
            }
        }
        .padding(8)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK")) {
                    guard viewModel.passwordChanged else { return }
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    private func makeOldPasswordInputView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Old Password")
                .font(.body)
            HStack {
                Image(systemName: "key")
                    .opacity(0.6)
                SecureField("Old Password", text: $viewModel.oldPassword)
                    .autocapitalization(.none)
                    .textContentType(.password)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
        }
        .padding(8)
        .disabled(viewModel.isInputDisabled())
    }
    
    private func makeNewPasswordInputView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("New Password (min \(Environment.passwordMinLength) characters)")
                .font(.body)
            HStack {
                Image(systemName: "key")
                    .opacity(0.6)
                SecureField("New Password", text: $viewModel.newPassword)
                    .autocapitalization(.none)
                    .textContentType(.newPassword)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
        }
        .padding(8)
        .disabled(viewModel.isInputDisabled())
    }
    
    private func makeConfirmButton() -> some View {
        Button(action: {
            viewModel.changePassword()
        }) {
            Text("Change Password")
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(7)
        }
        .padding(8)
        .disabled(viewModel.isChangePasswordDisabled())
    }
    
}

struct ChangePasswordView_Previews: PreviewProvider {
    
    static var previews: some View {
        ChangePasswordView()
    }
    
}
