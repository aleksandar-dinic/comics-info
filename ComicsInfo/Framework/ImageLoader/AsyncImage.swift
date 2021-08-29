//
//  AsyncImage.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 15/08/2021.
//

import SwiftUI

struct AsyncImage: View {
    
    @StateObject private var loader: ImageLoader
    private let placeholder: Image
    private let image: (UIImage) -> Image

    init(
       url: URL?,
       @ViewBuilder placeholder: () -> Image,
       @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
   ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(
            wrappedValue:
                ImageLoader(
                    url: url,
                    cache: SwiftUI.Environment(\.imageCache).wrappedValue
                )
        )
   }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
                    .font(.largeTitle)
            }
        }
    }

}
