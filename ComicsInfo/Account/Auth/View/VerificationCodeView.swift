//
//  VerificationCodeView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 26/12/2021.
//

import SwiftUI

struct VerificationCodeView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: VerificationCodeViewModel
    
    init(
        username: String,
        password: String
    ) {
        viewModel = VerificationCodeViewModel(
            username: username,
            password: password
        )
    }
    
    var body: some View {
        VStack(spacing: 4) {
            makeConfirmationCodeView()

            makeConfirmAccountButton()
            makeResendVerificationCodeButton()
        }
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
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
        }
        .padding(8)
    }
    
    private func makeConfirmAccountButton() -> some View {
        Button(action: {
            viewModel.confirmSignUp {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("Confirm Account")
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(7)
        }
        .padding(8)
        .disabled(viewModel.isConfirmAccountDisabled())
    }
    
    private func makeResendVerificationCodeButton() -> some View {
        Button(action: {
            viewModel.resendVerificationCode()
        }) {
            HStack {
                Text("Didn't receive a code?")
                    .foregroundColor(.secondary)
                Text("Resend it")
            }
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
        }
        .padding(8)
    }
    
}

struct VerificationCodeView_Previews: PreviewProvider {
    
    static var previews: some View {
        VerificationCodeView(username: "", password: "")
    }
    
}
