//
//  APISession.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Foundation
import RxSwift
import Alamofire

struct APISession: APIService {
    
    /// [GET]
    func getRequest<T>(with urlResource: URLResource<T>) -> Observable<Result<T, APIError>> where T : Decodable {
        
        Observable<Result<T, APIError>>.create { observer in
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            let task = AF.request(urlResource.resultURL,
                                  encoding: URLEncoding.default,
                                  headers: headers,
                                  interceptor: AuthInterceptor())
                .validate(statusCode: 200...399)
                .responseDecodable(of: SuccessResponseModel<T>.self) { response in
                    switch response.result {
                    case .success(let data):
                        guard let data = data.data else { return }
                        observer.onNext(.success(data))
                        
                    case .failure(let error):
                        dump(error)
                        guard let error = response.data else { return }
                        observer.onNext(urlResource.judgeError(data: error))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    /// [POST]
    func postRequest<T: Decodable>(with urlResource: URLResource<T>, param: Parameters?) -> Observable<Result<T, APIError>> {
        
        Observable<Result<T, APIError>>.create { observer in
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            let task = AF.request(urlResource.resultURL,
                                  method: .post,
                                  parameters: param,
                                  encoding: JSONEncoding.default,
                                  headers: headers,
                                  interceptor: AuthInterceptor())
                .validate(statusCode: 200...399)
                .responseDecodable(of: SuccessResponseModel<T>.self) { response in
                    switch response.result {
                    case .success(let data):
                        guard let data = data.data else { return }
                        observer.onNext(.success(data))
                        
                    case .failure(let error):
                        dump(error)
                        guard let error = response.data else { return }
                        observer.onNext(urlResource.judgeError(data: error))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    /// [POST] - multipartForm
    func postRequestWithImage<T: Decodable>(with urlResource: URLResource<T>, param: Parameters, image: UIImage, method: HTTPMethod) -> Observable<Result<T, APIError>> {
        
        Observable<Result<T, APIError>>.create { observer in
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            let task = AF.upload(multipartFormData: { (multipart) in
                for (key, value) in param {
                    multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
                }
                if let imageData = image.jpegData(compressionQuality: 1) {
                    multipart.append(imageData, withName: "files", fileName: "image.png", mimeType: "image/png")
                }
            }, to: urlResource.resultURL,
                                 method: method,
                                 headers: headers,
                                 interceptor: AuthInterceptor())
                .validate(statusCode: 200...399)
                .responseDecodable(of: SuccessResponseModel<T>.self) { response in
                    switch response.result {
                    case .success(let data):
                        guard let data = data.data else { return }
                        observer.onNext(.success(data))
                        
                    case .failure(let error):
                        dump(error)
                        guard let error = response.data else { return }
                        observer.onNext(urlResource.judgeError(data: error))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
