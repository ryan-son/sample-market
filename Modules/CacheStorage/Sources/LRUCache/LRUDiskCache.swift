//
//  LRUDiskCache.swift
//  CacheStorage
//
//  Created by Geonhee on 2023/01/26.
//

import Foundation

public final class LRUDiskCache: LRUCache {

  private let fileManager: FileManager
  private let userDefaults: UserDefaults
  private let cacheDirectory: URL
  let maxSize: Int
  private var accessDates: [URL: Date]

  init(
    fileManager: FileManager = .default,
    userDefaults: UserDefaults = .standard,
    cacheDirectory: URL? = nil,
    maxSize: Int,
    accessDates: [URL: Date] = [:]
  ) {
    self.fileManager = fileManager
    self.userDefaults = userDefaults
    self.cacheDirectory = cacheDirectory ?? fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    self.maxSize = maxSize
    self.accessDates = accessDates
  }

  func store(_ data: Data, for key: String) {
    let fileURL = cacheDirectory.appendingPathComponent(key)
    try? data.write(to: fileURL)
    accessDates[fileURL] = Date()
  }

  func retrieve(for key: String) -> Data? {
    let fileURL = cacheDirectory.appendingPathComponent(key)
    accessDates[fileURL] = Date()
    return try? Data(contentsOf: fileURL)
  }

  func remove(for key: String) {
    let fileURL = cacheDirectory.appendingPathComponent(key)
    try? fileManager.removeItem(at: fileURL)
    accessDates[fileURL] = nil
  }

  func removeLeastRecentlyUsed() {
    let sortedFiles = accessDates.sorted { $0.value < $1.value }
    guard let leastRecentlyUsedFileURL = sortedFiles.first?.key else { return }
    try? fileManager.removeItem(at: leastRecentlyUsedFileURL)
    accessDates[leastRecentlyUsedFileURL] = nil
  }

  func removeAll() {
    try? fileManager.removeItem(at: cacheDirectory)
    try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    accessDates.removeAll()
  }
}
