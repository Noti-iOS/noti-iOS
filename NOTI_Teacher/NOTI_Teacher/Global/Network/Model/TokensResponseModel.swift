//
//  TokensResponseModel.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/01/17.
//

import Foundation

struct TokensResponseModel: Codable {
    let accessToken: String
    let refreshToken: String
}

