#  UCD Apple Store
UCDAppleStore는 고가의 애플 제품들을 손쉽게 주문할 수 있도록 구성한 애플 스토어 전용 키오스크 앱입니다.

## 🗓️ 프로젝트 기간
2025년 6월 26일 ~ 7월 1일

## 📱 주요 기능

- **카테고리별 상품 필터링**: iPhone, iPad, MacBook, Mac, 악세서리
- **장바구니 관리**: 상품 추가/삭제, 수량 조절 (최대 10개)
- **시트 기반 장바구니 UI**: 3단계 높이 조절 (Low/Middle/High)
- **다국어 지원**: 한국어, 영어, 일본어
- **커스텀 디자인 시스템**: UCDButton, 다크 모드 대응

## 🏗️ 아키텍처

### MVVM (Model-View-ViewModel) 패턴

```
MainViewController (중앙 허브)
├── CategoryViewModel ↔ CategoryView
├── ProductViewModel ↔ ProductListView  
├── CartViewModel ↔ CartView (CartViewController)
└── AlertSystem (Extension)
```
#### 단방향 데이터 흐름
- **Delegate**: 사용자 입력을 위로 전달 (View → ViewController)
- **Closure**: 상태 변화를 아래로 알림 (ViewModel → ViewController → View)

#### 핵심 컴포넌트 역할

**Models**
- `Product`: 상품 정보 (id, name, category, price, imageURL)
- `CartItem`: 장바구니 아이템 (product + quantity)
- `Category`: 상품 카테고리 열거형
- `CartAlertType`: Alert 타입 정의

**ViewModels**
- `CategoryViewModel`: 카테고리 선택 상태 관리
- `ProductViewModel`: 상품 데이터 및 필터링 로직
- `CartViewModel`: 장바구니 상태 및 비즈니스 로직

**Views**
- `CategoryView`: 카테고리 버튼 UI
- `ProductListView`: 2x2 그리드 상품 목록 (페이징 지원)
- `CartView`: 장바구니 목록 및 결제 UI

**ViewControllers**
- `MainViewController`: 전체 화면 관리 및 ViewModel 연결
- `CartViewController`: 시트 모달로 표시되는 장바구니 화면


## 📁 프로젝트 구조

```
UCDAppleStore/
├── App/
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Models/
│   ├── Product.swift
│   ├── CartItem.swift
│   ├── Category.swift
│   └── CartAlertType.swift
├── ViewModels/
│   ├── CategoryViewModel.swift
│   ├── ProductViewModel.swift
│   └── CartViewModel.swift
├── Views/
│   ├── Category/
│   │   └── CategoryView.swift
│   ├── Product/
│   │   ├── ProductListView.swift
│   │   ├── ProductCell.swift
│   │   └── ProductView.swift
│   └── Cart/
│       ├── CartView.swift
│       └── CartItemCell.swift
├── ViewController/
│   ├── MainViewController.swift
│   └── CartViewController.swift
├── Protocols/
│   ├── CategoryViewDelegate.swift
│   ├── ProductListViewDelegate.swift
│   └── CartViewDelegate.swift
├── Utils/
│   ├── DesignSystem/
│   │   ├── UCDButton.swift
│   │   └── CartDetent.swift
│   └── Extensions/
│       ├── CartAlertType+Alert.swift
│       ├── String+Localization.swift
│       ├── Int+Formatting.swift
│       └── UIImageView+.swift
├── Managers/
│   ├── DataService.swift
│   └── DataServiceError.swift
└── Resources/
    ├── Assets.xcassets
    ├── Localizable.xcstrings
    └── product.json
```

## 🏃 역할 분담
|      팀원      | 역할                                                       |
|---------------|------------------------------------------------------------|
|     윤승렬     | 장바구니 담당 (CartView, CartViewModel), 알림, 다국어 담당         |
|     이서린     | 상품 목록 담당 (ProductListView, ProductViewModel)             |
|     양지영     | 아키텍처 설계, 카테고리, 장바구니 모달, 전체 연결 담당 (CategoryView, CategoryViewModel, MainViewController, DataService) |

## 🏃 역할 분담

| 팀원   | 역할 요약                          | 세부 담당 영역 |
|--------|------------------------------------|----------------|
| 윤승렬 | 장바구니, 알림, 다국어             | CartView, CartViewModel |
| 이서린 | 상품 목록                          | ProductListView, ProductViewModel |
| 양지영 | 아키텍처 설계, 카테고리, 전체 연결 | CategoryView, CategoryViewModel, MainViewController|


## 🛠️ 기술 스택
- Swift 5
- UIKit
- SnapKit
- Then
- Kingfisher
- MVVM + Delegate/Closure
