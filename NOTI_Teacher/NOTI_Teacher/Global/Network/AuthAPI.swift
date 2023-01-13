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
    /// [GET] 헤더에 kakaoAccessToken을 붙여 로그인을 요청하는 메서드
    func loginRequest<T: Decodable>(with urlResource: URLResource<T>, type: LoginType) -> Observable<NetworkResult<Any>> {
        Observable<NetworkResult<Any>>.create { observer in
            // TODO: - Apple 로그인 구현 후 추가
//            guard let token = type == .kakao
//                    ? UserDefaults.standard.string(forKey: UserDefaults.Keys.kakaoAccessToken)
//                    : UserDefaults.standard.string(forKey: UserDefaults.Keys.appleAccessToken)
//            else { fatalError() }
            
            // TODO: - FatalError 대신 로그인 화면으로 이동 메서드 구현
            guard let token = UserDefaults.standard.string(forKey: UserDefaults.Keys.kakaoAccessToken) else { fatalError() }
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "access-token": token
            ]
            
            let task = AF.request(urlResource.resultURL,
                                  method: .get,
                                  encoding: JSONEncoding.default,
                                  headers: headers)
                .validate(statusCode: 200...399)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .failure(let error):
                        dump(error)
                        guard let error = response.data else { return }
                        observer.onNext(urlResource.judgeError(data: error))
                    case .success(let data):
                        observer.onNext(.success(data))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
