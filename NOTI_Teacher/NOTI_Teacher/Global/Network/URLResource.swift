//
//  URLResource.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Foundation

struct URLResource<T: Decodable> {
    let baseURL = URL(string: "http://43.200.33.109:8080/")
    let path: String
    var resultURL: URL {
        return path.contains("http")
        ? URL(string: path)!
        : baseURL.flatMap { URL(string: $0.absoluteString + path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) }!
    }
    
    func judgeError(statusCode: Int) -> Result<T, APIError> {
        switch statusCode {
        case 400...409: return .failure(.decode)
        case 500: return .failure(.http(status: statusCode))
        default: return .failure(.unknown(status: statusCode))
        }
    }
}
