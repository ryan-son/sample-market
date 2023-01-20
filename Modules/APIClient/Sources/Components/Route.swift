//
//  Route.swift
//  APIClient
//
//  Created by Geonhee on 2023/01/20.
//

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
