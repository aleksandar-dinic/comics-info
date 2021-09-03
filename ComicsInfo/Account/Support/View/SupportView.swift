//
//  SupportView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 01/09/2021.
//

import SwiftUI

struct SupportView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = SupportViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                TextField("E-mail (optional)", text: $viewModel.email)
                    .padding(4)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 1))
                    .keyboardType(.emailAddress)
                TextEditor(text: $viewModel.message)
                    .padding(4)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .foregroundColor(viewModel.textEditorForegroundColor)
                        .onTapGesture {
                            viewModel.onTapTextEditor()
                        }
                makeSendButton()
            }
            .padding()
            .opacity(viewModel.isLoading ? 0.3 : 1)
            if viewModel.isLoading {
                ProgressView("Please wait...")
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationBarTitle("Support & Feedback", displayMode: .inline)
    }
    
    private func makeSendButton() -> some View {
        Button("Send") {
            viewModel.createFeedback(message: viewModel.message, email: viewModel.email)
        }
        .frame(height: 40)
        .disabled(viewModel.sendButtonIsDisabled)
        .frame(maxWidth: .infinity)
        .padding(4)
        .foregroundColor(Color.white)
        .background(Color.accentColor)
        .cornerRadius(4)
        .opacity(viewModel.sendButtonIsDisabled ? 0.3 : 1)
    }
    
}

struct SupportView_Previews: PreviewProvider {
    
    static var previews: some View {
        SupportView()
    }
    
}
