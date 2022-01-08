//
//  SignInView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import SwiftUI
import AuthenticationServices
import Amplify

struct SignInView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = SignInViewModel()
    @Binding var showen: Bool
    @FocusState private var focusedField: SignInViewModel.Field?
    
    var body: some View {
        ZStack {
            VStack(spacing: 4) {
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                if !viewModel.showConfirmCode {
                    makeUsernameInputView()
                    makePasswordInputView()
                    
                    makeForgotPassword()
                    
                    makeSignInButton()
                    makeSignInWithAppleButton()
                    
                    makeSignUpButton()
                } else {
                    VerificationCodeView(
                        username: viewModel.username,
                        password: viewModel.password
                    )
                }

                Spacer()
            }
            .onSubmit {
                switch focusedField {
                case .username:
                    focusedField = .password
                case .password:
                    viewModel.signIn {
                        presentationMode.wrappedValue.dismiss()
                    }
                case .none:
                    break
                }
            }
            
            if viewModel.isLoading {
                MainProgressView()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .padding()
    }
    
    private func makeUsernameInputView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Username")
                .font(.body)
            HStack {
                Image(systemName: "person")
                    .opacity(0.6)
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .username)
                    .textContentType(.username)
                    .submitLabel(.next)
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
    
    private func makePasswordInputView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Password (min \(Environment.passwordMinLength) characters)")
                .font(.body)
            HStack {
                Image(systemName: "key")
                    .opacity(0.6)
                SecureField("Password", text: $viewModel.password)
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .password)
                    .textContentType(.password)
                    .submitLabel(.join)
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
    
    private func makeForgotPassword() -> some View {
        HStack {
            NavigationLink(destination: ResetPasswordView()) {
                Text("Forgot your password?")
            }
            .disabled(viewModel.isInputDisabled())
            Spacer()
        }
        .padding([.leading, .trailing, .bottom], 8)
    }
    
    private func makeSignInButton() -> some View {
        Button(action: {
            viewModel.signIn {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("Sign in")
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(8)
        }
        .padding(8)
        .padding(.bottom, 8)
        .disabled(viewModel.isSignInDisabled())
    }
    
    private func makeSignInWithAppleButton() -> some View {
        Button(action: {
            viewModel.signInWithApple {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            HStack {
                Image(systemName: "applelogo")
                Text("Sign in with Apple")
            }
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            .foregroundColor(Color.black)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black, lineWidth: 1)
            )
        }
        .padding(8)
        .padding(.bottom, 8)
    }
    
    private func makeSignUpButton() -> some View {
        Button(action: {
            showen.toggle()
        }) {
            HStack {
                Text("Need an account?")
                    .foregroundColor(.secondary)
                Text("Sign up")
            }
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
        }
        .padding(8)
        .padding(.bottom, 8)
        .disabled(viewModel.isInputDisabled())
    }
    
}

struct SignInView_Previews: PreviewProvider {
    
    @State static private var showen = false
    
    static var previews: some View {
        SignInView(showen: $showen)
    }

}
