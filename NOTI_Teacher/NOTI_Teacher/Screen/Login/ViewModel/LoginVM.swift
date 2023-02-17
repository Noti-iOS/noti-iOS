//
//  LoginVM.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/12.
//

import Foundation
import RxCocoa
import RxSwift
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class LoginVM: BaseViewModel {
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    var bag = DisposeBag()
    var input = Input()
    var output = Output()
    
    // MARK: - Input
    
    struct Input {}
    
    // MARK: - Output
    
    struct Output {
        var loginResponse = PublishRelay<Bool>()
    }
    
    // MARK: - Init
    
    init() {
        bindInput()
        bindOutput()
    }
    
    deinit {
        bag = DisposeBag()
    }
}

// MARK: - Helpers

extension LoginVM {}

// MARK: - Input

extension LoginVM: Input {
    func bindInput() {}
}

// MARK: - Output

extension LoginVM: Output {
    func bindOutput() {}
}

// MARK: - Networking

extension LoginVM {
    /// 카카오 로그인버튼을 눌렀을 때 카카오 토큰을 저장하고 기존 유저인지 판단 메서드를 호출하는 메서드
    func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    UserDefaults.standard.set(oauthToken?.accessToken, forKey: UserDefaults.Keys.kakaoAccessToken)
                    self.loginRequest(type: .kakao)
                }
            }
        } else {
            // 시뮬레이터용 Account 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    UserDefaults.standard.set(oauthToken?.accessToken, forKey: UserDefaults.Keys.kakaoAccessToken)
                    self.loginRequest(type: .kakao)
                }
            }
        }
    }
    
    func loginRequest(type: LoginType, nickname: String? = nil) {
        let path = "api/teacher/login/\(type.rawValue)"
        let resource = URLResource<TokensResponseModel>(path: path)
        
        AuthAPI.shared.loginRequest(with: resource, token: type.token, nickname: nickname)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success:
                    owner.output.loginResponse.accept(true)
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
}
