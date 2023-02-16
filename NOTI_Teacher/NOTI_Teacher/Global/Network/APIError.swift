//
//  APIError.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/02/16.
//

import Foundation

enum APIError: Error {
    case badGateway
    case error(_ errorModel: ErrorResponseModel)
}

extension APIError {
    var message: String {
        switch self {
        case .badGateway:
            return "502 Bad Gateway"
        case .error(error: let error):
            return error.message
        }
    }
}
