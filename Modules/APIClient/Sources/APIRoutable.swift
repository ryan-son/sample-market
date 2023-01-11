//
//  APIRoutable.swift
//  APIClient
//
//  Created by Geonhee on 2023/01/11.
//

import Foundation

/// 네트워크 API가 준수하는 타입.
public protocol APIRoutable {
  /// API의 BaseURL. 편의에 따라 도메인 뿐만 아니라 path parameter가 포함될 수 있다.
  var baseURL: URL { get }
  /// HTTP 메서드와 path parameter.
  var route: Route { get }
  /// 요청에 설정할 헤더.
  var headers: [String: String]? { get }
}

/// HTTP 메서드와 path parameter를 함께 정의한 타입
public enum Route {
  case get(String)
  case post(String)
  case patch(String)
  case delete(String)

  public var path: String {
    switch self {
    case .get(let path),
        .post(let path),
        .patch(let path),
        .delete(let path):
      return path
    }
  }

  public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
  }

  public var method: HTTPMethod {
    switch self {
    case .get: return .get
    case .post: return .post
    case .patch: return .patch
    case .delete: return .delete
    }
  }
}
