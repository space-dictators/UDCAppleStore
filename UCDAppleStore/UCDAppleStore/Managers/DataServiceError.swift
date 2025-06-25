//
//  DataServiceError.swift
//  UCDAppleStore
//
//  Created by Milou on 6/25/25.
//

import Foundation

enum DataServiceError: Error, LocalizedError {
    case fileNotFound
    case decodingFailed(DecodingError)
    case parsingFailed(Error)
    case emptyData

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "JSON 파일을 찾을 수 없습니다."
        case let .decodingFailed(error):
            return "JSON 파싱에 실패했습니다: \(error.localizedDescription)"
        case let .parsingFailed(error):
            return "데이터 파싱에 실패했습니다: \(error.localizedDescription)"
        case .emptyData:
            return "데이터가 비었습니다."
        }
    }
}
