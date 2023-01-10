//
//  ErrorResponse.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/01/10.
//

import Foundation

struct ErrorResponse: Codable {
    let message: String
    let status: Int
    let errors: [FieldError]
    let code: String
}

// MARK: - FieldError
struct FieldError: Codable {
    let field, value, reason: String
}
