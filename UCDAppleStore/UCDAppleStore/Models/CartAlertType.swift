import Foundation

// Alert종류를 나타내는 enum
enum CartAlertType {
    case quantityLimitExceeded // 10개에서 +버튼을 눌렀을 때
    case confirmRemoveItem(Product) // 수량 1개에서 -버튼 눌렀을 때 삭제 여부
    case confirmClearCart // 초기화 버튼을 눌렀을 때
}
