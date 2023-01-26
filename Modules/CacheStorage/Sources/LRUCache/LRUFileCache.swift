//
//  LRUFileCache.swift
//  CacheStorage
//
//  Created by Geonhee on 2023/01/26.
//

import Foundation

public final class LRUFileCache: LRUCache {

  private let fileManager: FileManager
  private let cacheDirectory: URL
  private var accessDates: [URL: Date]

  public init(
    fileManager: FileManager = .default,
    cacheDirectory: URL,
    accessDates: [URL: Date] = [:]
  ) {
    self.fileManager = fileManager
    self.cacheDirectory = cacheDirectory
    self.accessDates = accessDates
  }

  public func store(_ data: Data, for key: String) {
    let fileURL = cacheDirectory.appendingPathComponent(key)
    try? data.write(to: fileURL)
    accessDates[fileURL] = Date()
  }

  public func retrieve(for key: String) -> Data? {
    let fileURL = cacheDirectory.appendingPathComponent(key)
    accessDates[fileURL] = Date()
    return try? Data(contentsOf: fileURL)
  }

  public func remove(for key: String) {
    let fileURL = cacheDirectory.appendingPathComponent(key)
    try? fileManager.removeItem(at: fileURL)
    accessDates[fileURL] = nil
  }

  public func removeLeastRecentlyUsed() {
    let sortedFiles = accessDates.sorted { $0.value < $1.value }
    guard let leastRecentlyUsedFileURL = sortedFiles.first?.key else { return }
    try? fileManager.removeItem(at: leastRecentlyUsedFileURL)
    accessDates[leastRecentlyUsedFileURL] = nil
  }

  public func removeAll() {
    try? fileManager.removeItem(at: cacheDirectory)
    try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    accessDates.removeAll()
  }
}
