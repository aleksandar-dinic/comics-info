//
//  ImageCache.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 15/08/2021.
//

import UIKit
import SwiftUI

protocol ImageCache {
    
    subscript(_ url: URL) -> UIImage? { get set }
    
}

struct TemporaryImageCache: ImageCache {
    
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get {
            cache.object(forKey: key as NSURL)
        }
        set {
            guard let value = newValue else {
                cache.removeObject(forKey: key as NSURL)
                return
            }
            cache.setObject(value, forKey: key as NSURL) }
    }
    
}

struct ImageCacheKey: EnvironmentKey {
    
    static let defaultValue: ImageCache = TemporaryImageCache()
    
}

extension EnvironmentValues {
    
    var imageCache: ImageCache {
        get {
            self[ImageCacheKey.self]
        }
        set {
            self[ImageCacheKey.self] = newValue
        }
    }
    
}
