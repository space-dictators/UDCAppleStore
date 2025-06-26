//
//  DataService.swift
//  UCDAppleStore
//
//  Created by Milou on 6/25/25.
//

import Foundation

class DataService {
    static let shared = DataService()

    private init() {}

    ///  상품 데이터를 로드합니다
    ///
    /// 사용법
    /// ```swift
    /// let products = DataService.shared.loadProducts()
    /// // 에러 처리 필요 없음! 항상 [Product] 배열 반환
    /// ```
    ///
    /// - Returns: 상품 배열 (에러 시 빈 배열)
    /// - Note: 에러가 발생해도 앱이 크래시되지 않습니다
    func loadProducts() -> [Product] {
        do {
            return try loadData()
        } catch {
            print("❌ 데이터 로딩 실패: \(error.localizedDescription)")
            return []
        }
    }

    /// 에러를 던지는 버전 (디버깅할 때만 사용)
    /// -  Warning: 이 메서드를 직접 사용하지 마세요!
    func loadData() throws -> [Product] {
        guard let url = Bundle.main.url(forResource: "product", withExtension: "json") else {
            throw DataServiceError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Product].self, from: data)
        } catch let decodingError as DecodingError {
            throw DataServiceError.decodingFailed(decodingError)
        } catch {
            throw DataServiceError.parsingFailed(error)
        }
    }
}
