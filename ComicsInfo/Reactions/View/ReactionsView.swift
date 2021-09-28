//
//  ReactionsView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import SwiftUI

struct ReactionsView: View {
    
    @ObservedObject private var viewModel: ReactionsViewModel
    private let shereMessage: String
    private let onTapBookmark: () -> Void
    
    init(
        isBookmarked: Bool,
        shereMessage: String,
        onTapBookmark: @escaping () -> Void
    ) {
        self.viewModel = ReactionsViewModel(isBookmarked: isBookmarked)
        self.shereMessage = shereMessage
        self.onTapBookmark = onTapBookmark
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "square.and.arrow.up")
                .font(.title2)
                .onTapGesture {
                    viewModel.actionSheet(shereMessage)
                    successFeedback()
                }
//            viewModel.heartImage
//                .font(.title2)
//                .onTapGesture {
//                    viewModel.onTapHeart()
//                    successFeedback()
//                }
//                .foregroundColor(.red)
            Spacer()
            viewModel.bookmarkImage
                .font(.title2)
                .onTapGesture {
                    viewModel.onTapBookmark()
                    onTapBookmark()
                    successFeedback()
                }
        }
        .foregroundColor(Color("AccentColor"))
        .padding([.top, .bottom], 8)
        .padding([.leading, .trailing])
    }
    
    private func successFeedback() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.success)
    }
    
}

struct ReactionsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ReactionsView(
            isBookmarked: false,
            shereMessage: "Hello from preview"
        ) {
            print("Bookmark tapped")
        }
    }
    
}
