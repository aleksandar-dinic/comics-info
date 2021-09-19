//
//  ImageLoader.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 15/08/2021.
//

import SwiftUI
import Combine
import Foundation

final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    private let url: URL?
    private var cancellable: AnyCancellable?
    private var cache: Cache<URL, Data>
    private(set) var isLoading = false
    private static let queue = DispatchQueue(label: String(describing: ImageLoader.self))

    init(url: URL?, cache: Cache<URL, Data> = Cache<URL, Data>(maximumEntryCount: 10_000)) {
        self.url = url
        self.cache = cache
    }

    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading, let url = url else { return }

        if let data = cache[url], let image = UIImage(data: data) {
            self.image = image
            return
        }
        
        if let data = cache.getImageFromDisc(withName: url.lastPathComponent), let image = UIImage(data: data) {
            cache[url] = data
            self.image = image
            return
        }
        
        print("Downloading image from: \(url)")
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.queue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    private func onStart() {
        isLoading = true
    }
        
    private func onFinish() {
        isLoading = false
    }

    func cancel() {
        cancellable?.cancel()
    }
    
    private func cache(_ image: UIImage?) {
        guard let url = url, let data = image?.pngData() else { return }
        cache[url] = data
        try? cache.saveImageToDisc(data, withName: url.lastPathComponent)
    }
    
}
