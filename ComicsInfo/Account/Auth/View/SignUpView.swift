//
//  SignUpView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject private var viewModel = SignUpViewModel()
    @Binding var showSignIn: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 4) {
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                if !viewModel.showConfirmCode {
                    makeUsernameInputView()
                    makeEmailInputView()
                    makePasswordInputView()

                    makeSignUpButton()
                    makeSignInButton()
                } else {
                    VerificationCodeView(
                        username: viewModel.username,
                        password: viewModel.password
                    )
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
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func makeUsernameInputView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Username")
                .font(.body)
            HStack {
                Image(systemName: "person")
                    .opacity(viewModel.imageOpacity())
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .textContentType(.username)
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
    
    private func makeEmailInputView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Email")
                .font(.body)
            HStack {
                Image(systemName: "envelope")
                    .opacity(viewModel.imageOpacity())
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
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
    
    private func makePasswordInputView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Password (min \(Environment.passwordMinLength) characters)")
                .font(.body)
            HStack {
                Image(systemName: "key")
                    .opacity(viewModel.imageOpacity())
                SecureField("Password", text: $viewModel.password)
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
    
    private func makeSignUpButton() -> some View {
        Button(action: {
            viewModel.signUp()
        }) {
            Text("Sign Up")
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(8)
        }
        .padding(8)
        .disabled(viewModel.isSignUpDisabled())
    }
    
    private func makeSignInButton() -> some View {
        Button(action: {
            showSignIn.toggle()
        }) {
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.secondary)
                Text("Sign in")
            }
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
        }
        .padding(8)
        .disabled(viewModel.isInputDisabled())
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    
    @State static private var showSignIn = false
    
    static var previews: some View {
        SignUpView(showSignIn: $showSignIn)
    }

}
