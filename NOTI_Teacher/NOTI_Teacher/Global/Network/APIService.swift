//
//  APIService.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Alamofire
import RxSwift

protocol APIService {
    func getRequest<T: Decodable>(with urlResource: URLResource<T>) -> Observable<Result<T, APIError>>
    
    func postRequest<T: Decodable>(with urlResource: URLResource<T>, param: Parameters?) -> Observable<Result<T, APIError>>
    
    func postRequestWithImage<T: Decodable>(with urlResource: URLResource<T>, param: Parameters, image: UIImage, method: HTTPMethod) -> Observable<Result<T, APIError>>
}
