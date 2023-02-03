//
//  NetworkResult.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/01/10.
//

import Foundation

enum NetworkResult<T>: Error {
    case success(T)
    case error(T)
    case pathError
}
