# Sample Market

OOP를 고려하여 기능 그룹핑 및 모듈화를 집중적으로 학습하기 위한 프로젝트

- Xcode Version: 14.1
- Tuist Version: 3.10.0

## Getting Started

1. 터미널에 아래 명령을 입력하여 Tuist를 설치합니다.
```bash
curl -Ls https://install.tuist.io | bash
```
2. 레포지토리를 클론 받습니다.
```bash
git clone https://github.com/ryan-son/sample-market.git
```
3. Tuist 명령을 통해 프로젝트와 워크스페이스를 생성합니다.
```bash
tuist generate
# 현재는 외부 의존성이 없으므로 의존성을 가져오는 `tuist fetch` 명령을 하지 않아도 됨.
```
4. 빌드하고 실행합니다.

## Modules

| 모듈 | 역할 | 메인 타겟 타입 |
| --- | --- | --- |
| `APIClient` | 각 네트워크 기능의 기초 기능 제공 | Dynamic Framework |
| `App` | 메인 앱 | iOS App |
| `CacheStorage` | 각종 캐시 스토리지 기초 기능 제공. 현재는 LRU Cache가 일부 구현되어 있음 | Dynamic Framework |
| `CoreLibraries` | 기능 개발에 필요한 서드 파티 라이브러리 묶음 | Dynamic Framework |
| `ImageCacheStorage` | `CacheStorage` 모듈을 이용해 구현한 이미지용 캐시 스토리지 모듈. 메모리 및 디스크 캐싱 기능 있음. | Dynamic Framework |
| `ImageClient` | `APIClient`를 이용하여 이미지를 받아오고 캐싱하는 역할을 수행하는 모듈 | Dynamic Framework |
| `MarketClient` | `APIClient`를 이용하여 상품 API로 수행할 수 있는 역할을 수행하는 모듈 | Dynamic Framework |
| `MarketHome` | `MarketHomeCore` 모듈을 이용하여 상품 홈 화면을 제공하는 모듈. 타겟을 추가해 샘플 앱을 제공할 수 있음 | Dynamic Framework |
| `MarketHomeCore` | 상품 홈 화면을 그리는 데 필요한 역할을 수행하는 모듈 | Static Library |
| `SMDesignSystem` | 뷰를 담당하는 복수의 모듈에서 공용으로 사용할 수 있는 디자인 시스템을 구현한 모듈. 색상, 이미지와 같은 리소스가 추가되면 SwiftGen 템플릿으로 생성된 SwiftUI 코드를 자동으로 생성함 | Dynamic Framework |
| `SMFoundation` | 복수의 모듈에서 공용으로 사용되는 기능을 모아둔 모듈. Primitive type의 확장 또는 프로토콜 기본 구현이 주로 들어감 | Dynamic Framework |
| `SharedModels` | 복수의 모듈에서 공용으로 사용되는 도메인 모델과 DTO 타입을 모아둔 모듈 | Dynamic Framework | 
