//
//  AuthAPI.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/01/10.
//

import Alamofire
import RxSwift

struct AuthAPI {
    /// 간편하게 API를 호출할 수 있도록 제공되는 공용 싱글톤 객체
    static let shared = AuthAPI()
}

// MARK: - API

extension AuthAPI {
    /// 토큰 갱신 시 자체 accessToken과 refreshToken을 저장하는 메서드
    func setUserDefaultsToken(_ tokens: TokensResponseModel) {
        UserDefaults.standard.set(tokens.accessToken, forKey: UserDefaults.Keys.accessToken)
        UserDefaults.standard.set(tokens.refreshToken, forKey: UserDefaults.Keys.refreshToken)
    }
    
    /// [GET] 헤더에 kakaoAccessToken을 붙여 로그인을 요청하는 메서드
    func loginRequest<T: Decodable>(with urlResource: URLResource<T>, token: String, nickname: String? = nil) -> Observable<Result<T, APIError>> {
        Observable<Result<T, APIError>>.create { observer in
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "access-token": token
            ]
            
            let param: Parameters? = nickname != nil ? ["nickname" : nickname!] : nil
            
            let task = AF.request(urlResource.resultURL,
                                  method: .post,
                                  parameters: param,
                                  encoding: JSONEncoding.default,
                                  headers: headers)
                .validate(statusCode: 200...399)
                .responseDecodable(of: T.self) { response in
                    dump(response)
                    switch response.result {
                    case .success(let data):
                        guard let token = data as? TokensResponseModel else { return }
                        setUserDefaultsToken(token)
                        observer.onNext(.success(data))
                        
                    case .failure:
                        guard let error = response.data else { return }
                        observer.onNext(urlResource.judgeError(data: error))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    /// [GET] refreshToken으로 accessToken, refreshToken 재발급
    func renewalToken() -> Observable<Result<TokensResponseModel, APIError>> {
        
        Observable<Result<TokensResponseModel, APIError>>.create { observer in
            guard let refreshToken = UserDefaults.standard.string(forKey: UserDefaults.Keys.refreshToken) else { fatalError() }
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(refreshToken)"
            ]
            
            let path = "api/auth/reissue"
            let urlResource = URLResource<TokensResponseModel>(path: path)
            
            let task = AF.request(urlResource.resultURL,
                                  method: .post,
                                  encoding: URLEncoding.default,
                                  headers: headers)
                .validate(statusCode: 200...399)
                .responseDecodable(of: TokensResponseModel.self) { response in
                    switch response.result {
                    case .success(let data):
                        setUserDefaultsToken(data)
                        observer.onNext(.success(data))
                        
                    case .failure:
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
