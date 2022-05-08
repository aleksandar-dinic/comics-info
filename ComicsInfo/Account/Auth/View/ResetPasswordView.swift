//
//  ResetPasswordView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/12/2021.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = ResetPasswordViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 4) {
                Text("Forgot Password?")
                    .font(.largeTitle)
                    .padding()
                
                makeUsernameInputView()
                
                if !viewModel.showConfirmCode {
                    makeResetPasswordButton()
                } else {
                    makeNewPasswordInputView()
                    makeConfirmationCodeView()
                    makeConfirmResetPasswordButton()
                }

                Spacer()
            }
            
            if viewModel.isLoading {
                MainProgressView()
            }
        }
        .padding()
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK")) {
                    guard viewModel.passwordHasBeenReset else { return }
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    private func makeUsernameInputView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Username")
                .font(.body)
            HStack {
                Image(systemName: "person")
                    .opacity(viewModel.usernameInputOpacity())
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .disabled(viewModel.isUsernameDisabled())
                    .opacity(viewModel.usernameInputOpacity())
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.accentColor, lineWidth: 1)
                    .opacity(viewModel.usernameInputOpacity())
            )
        }
        .padding(8)
        .disabled(viewModel.passwordHasBeenReset)
    }
    
    private func makeResetPasswordButton() -> some View {
        Button(action: {
            viewModel.resetPassword()
        }) {
            Text("Reset Password")
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(7)
        }
        .padding(8)
        .disabled(viewModel.isResetPasswordDisabled())
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
                    .disabled(viewModel.isInputDisabled())
                    .opacity(viewModel.inputOpacity())
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.accentColor, lineWidth: 1)
                    .opacity(viewModel.inputOpacity())
            )
        }
        .padding(8)
    }
    
    private func makeConfirmationCodeView() -> some View {
        VStack(alignment: .leading) {
            Text("Enter the verification code received via email")
                .font(.footnote)
            HStack {
                Image(systemName: "qrcode")
                    .opacity(0.6)
                TextField("Verification code", text: $viewModel.confirmationCode)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .disabled(viewModel.isInputDisabled())
                    .opacity(viewModel.inputOpacity())
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.accentColor, lineWidth: 1)
                    .opacity(viewModel.inputOpacity())
            )
        }
        .padding(8)
    }
    
    private func makeConfirmResetPasswordButton() -> some View {
        Button(action: {
            viewModel.confirmResetPassword()
        }) {
            Text("Send")
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(7)
        }
        .padding(8)
        .disabled(viewModel.isConfirmResetPasswordDisabled())
    }
    
}

struct ResetPasswordView_Previews: PreviewProvider {
    
    static var previews: some View {
        ResetPasswordView()
    }

}
