//
//  BookmarkView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import SwiftUI

struct BookmarkView: View {
    
    @ObservedObject private var viewModel: BookmarkViewModel
    
    init(_ viewModel: BookmarkViewModel = BookmarkViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.isBookmarkEmpty {
                makeEmptyMessage()
            } else {
                makeBookmarks()
            }
        }
        .onAppear {
            viewModel.getBookmarks()
        }
        .navigationBarTitle("Bookmarks", displayMode: .inline)
    }
    
    private func makeEmptyMessage() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("You haven't added any items to your Bookmarks yet")
                .font(.title)
            Text("When you do, they will show up here.")
                .font(.title3)
        }
        .padding()
    }
    
    private func makeBookmarks() -> some View {
        ScrollView {
            LazyVStack(spacing: 4, pinnedViews: [.sectionHeaders]) {
                ForEach(viewModel.characters, id: \.identifier) { character in
                    Section(header: makeHeader("Characters")) {
                        NavigationLink(destination: CharacterInfoView(for: character)) {
                            CharacterView(for: character)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
            
            LazyVStack(spacing: 4, pinnedViews: [.sectionHeaders]) {
                ForEach(viewModel.comics, id: \.identifier) { comic in
                    Section(header: makeHeader("Comics")) {
                        ComicSummaryView(
                            for: ComicSummary(from: comic),
                            seriesTitle: ""
                        )
                    }
                }
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
        }
    }
    
    private func makeHeader(_ title: String) -> some View {
        HStack {
            Text(title)
            Spacer()
        }
        .padding(4)
        .background(Color.secondary)
    }
    
}

struct BookmarkView_Previews: PreviewProvider {
    
    static var previews: some View {
        BookmarkView()
    }
    
}
