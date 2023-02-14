//
//  ErrorResponseModel.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/01/10.
//

import Foundation

struct ErrorResponseModel: Codable {
    let message: String
    let status: Int
    let errors: [FieldError]
    let code: String
}

// MARK: - FieldError
struct FieldError: Codable {
    let field: String
    let value: String
    let reason: String
}
