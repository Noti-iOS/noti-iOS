//
//  APIService.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Alamofire
import RxSwift

protocol APIService {
    func getRequest<T: Decodable>(with urlResource: URLResource<T>) -> Observable<NetworkResult<Any>>
    
    func postRequest<T: Decodable>(with urlResource: URLResource<T>, param: Parameters?) -> Observable<NetworkResult<Any>>
    
    func postRequestWithImage<T: Decodable>(with urlResource: URLResource<T>, param: Parameters, image: UIImage, method: HTTPMethod) -> Observable<NetworkResult<Any>>
}
