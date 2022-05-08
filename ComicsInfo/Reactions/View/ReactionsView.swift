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
    private let onTapAdd: () -> Void
    private let onTapBookmark: () -> Void
    
    init(
        types: [ReactionType] = ReactionType.allCases,
        isInMyComics: Binding<Bool>,
        isBookmarked: Bool,
        shereMessage: String,
        onTapAdd: @escaping () -> Void,
        onTapBookmark: @escaping () -> Void
    ) {
        self.viewModel = ReactionsViewModel(
            types: types,
            isInMyComics: isInMyComics,
            isBookmarked: isBookmarked
        )
        self.shereMessage = shereMessage
        self.onTapAdd = onTapAdd
        self.onTapBookmark = onTapBookmark
    }
    
    var body: some View {
        HStack(spacing: 16) {
            if viewModel.isAvailable(.share) {
                Image(systemName: "square.and.arrow.up")
                    .font(.title2)
                    .onTapGesture {
                        viewModel.actionSheet(shereMessage)
                        successFeedback()
                    }
            }
            
//            viewModel.heartImage
//                .font(.title2)
//                .onTapGesture {
//                    viewModel.onTapHeart()
//                    successFeedback()
//                }
//                .foregroundColor(.red)
            Spacer()
            if viewModel.isAvailable(.add) {
                viewModel.addImage
                    .font(.title2)
                    .onTapGesture {
                        onTapAdd()
                        successFeedback()
                    }
            }
            if viewModel.isAvailable(.bookmark) {
                viewModel.bookmarkImage
                    .font(.title2)
                    .onTapGesture {
                        viewModel.onTapBookmark()
                        onTapBookmark()
                        successFeedback()
                    }
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
            isInMyComics: .constant(false),
            isBookmarked: false,
            shereMessage: "Hello from preview",
            onTapAdd: { print("Add tapped") },
            onTapBookmark: { print("Bookmark tapped") }
        )
    }
    
}
