//
//  URLResource.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Foundation

struct URLResource<T: Codable> {
    let baseURL = URL(string: "http://43.200.35.14/")
    let path: String
    var resultURL: URL {
        return path.contains("http")
        ? URL(string: path)!
        : baseURL.flatMap { URL(string: $0.absoluteString + path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) }!
    }
    
    func judgeError(data: Data) -> Result<T, APIError> {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(ErrorResponseModel.self, from: data) else {
            return .failure(.badGateway)
        }
        
        return .failure(.error(decodeData))
    }
}
