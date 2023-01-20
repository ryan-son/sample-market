//
//  APIRoutable.swift
//  APIClient
//
//  Created by Geonhee on 2023/01/20.
//

import Foundation

/// 네트워크 API가 준수하는 타입.
public protocol APIRoutable {
  /// API의 BaseURL. 편의에 따라 도메인 뿐만 아니라 path parameter가 포함될 수 있다.
  var baseURL: String { get }
  /// HTTP 메서드와 path parameter.
  var route: Route { get }
  /// 요청을 통해 전달할 파라미터
  var parameters: Parameters { get }
  /// 테스트에 사용할 샘플 데이터
  var sampleData: Data { get }
  /// 요청에 설정할 헤더.
  var headers: [String: String]? { get }
}

public extension APIRoutable {
  var sampleData: Data {
    return Data()
  }
}
