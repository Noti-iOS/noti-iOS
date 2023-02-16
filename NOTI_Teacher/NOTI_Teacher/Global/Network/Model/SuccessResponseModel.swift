//
//  SuccessResponseModel.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/02/14.
//

import Foundation

struct SuccessResponseModel<T: Codable>: Codable {
    let message: String
    let status: Int
    let data: T?
}
