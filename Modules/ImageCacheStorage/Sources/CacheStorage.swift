//
//  CacheStorage.swift
//  ImageCacheStorage
//
//  Created by Geonhee on 2023/01/24.
//

import Foundation

protocol CacheStorage {
  func data<Key>(for key: Key) async -> Data?
  func store<Key>(data: Data, for key: Key)
}
