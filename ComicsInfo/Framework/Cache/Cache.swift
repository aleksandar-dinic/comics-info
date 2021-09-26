//
//  Cache.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 27/08/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class Cache<Key: Hashable, Value>: Codable where Key: Codable, Value: Codable {
    
    private let cache = NSCache<KeyWrapper, CacheEntry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    private let keyTracker = KeyTracker()
    private let queue: DispatchQueue

    init(
        dateProvider: @escaping () -> Date = Date.init,
        entryLifetime: TimeInterval = 31 * 24 * 60 * 60,
        maximumEntryCount: Int = 50_000,
        queue: DispatchQueue = DispatchQueue(
            label: String(describing: Cache.self),
            attributes: .concurrent
        )
    ) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        cache.countLimit = maximumEntryCount
        cache.delegate = keyTracker
        self.queue = queue
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.singleValueContainer()
        let entries = try container.decode([CacheEntry].self)
        entries.forEach(insert)
    }
    
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = CacheEntry(key: key, value: value, expirationDate: date)
        cache.setObject(entry, forKey: KeyWrapper(key))
        keyTracker.keys.insert(key)
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = cache.object(forKey: KeyWrapper(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }

        return entry.value
    }
    
    func values() -> [Value]? {
        queue.sync {
            var values = [Value]()
            for key in keyTracker.keys {
                guard let value = value(forKey: key) else { continue }
                values.append(value)
            }
            
            return !values.isEmpty ? values : nil
        }
    }

    func removeValue(forKey key: Key) {
        cache.removeObject(forKey: KeyWrapper(key))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(entry))
    }

    func saveToDisc(
        _ name: CacheKey,
        using fileManager: FileManager = .default
    ) throws {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )

        let fileURL = folderURLs[0].appendingPathComponent(name.rawValue + ".cache")
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
    
    static func getFromDisc(
        _ name: CacheKey,
        using fileManager: FileManager = .default
    ) -> Self? {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        let fileURL = folderURLs[0].appendingPathComponent(name.rawValue + ".cache")
        guard let data = try? String(contentsOf: fileURL).data(using: .utf8) else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
    
    func saveImageToDisc(
        _ data: Data,
        withName name: String,
        using fileManager: FileManager = .default
    ) throws {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        let imagesURL = folderURLs[0].appendingPathComponent("Images")
        try fileManager.createDirectory(atPath: imagesURL.path, withIntermediateDirectories: true)

        let fileURL = folderURLs[0].appendingPathComponent("Images/\(name)")
        try data.write(to: fileURL)
    }
    
    func getImageFromDisc(
        withName name: String,
        using fileManager: FileManager = .default
    ) -> Data? {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        let fileURL = folderURLs[0].appendingPathComponent("Images/\(name)")
        return try? Data(contentsOf: fileURL)
    }
    
    subscript(key: Key) -> Value? {
        get {
            queue.sync {
                value(forKey: key)
            }
        }
        set {
            queue.sync(flags: .barrier) {
                guard let value = newValue else {
                    removeValue(forKey: key)
                    return
                }

                insert(value, forKey: key)
            }
        }
    }

}

private extension Cache {
    
    func entry(forKey key: Key) -> CacheEntry? {
        guard let entry = cache.object(forKey: KeyWrapper(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }

        return entry
    }

    func insert(_ entry: CacheEntry) {
        cache.setObject(entry, forKey: KeyWrapper(entry.key))
        keyTracker.keys.insert(entry.key)
    }
    
}

private extension Cache {
    
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys = Set<Key>()

        func cache(
            _ cache: NSCache<AnyObject, AnyObject>,
            willEvictObject object: Any
        ) {
            guard let entry = object as? CacheEntry else {
                return
            }

            keys.remove(entry.key)
        }
    }
    
    final class KeyWrapper: NSObject {
        let key: Key

        init(_ key: Key) {
            self.key = key
        }

        override var hash: Int {
            key.hashValue
        }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? KeyWrapper else {
                return false
            }

            return value.key == key
        }

    }
    
    final class CacheEntry {
        let key: Key
        let value: Value
        let expirationDate: Date

        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
    
}

extension Cache.CacheEntry: Codable where Key: Codable, Value: Codable {}
