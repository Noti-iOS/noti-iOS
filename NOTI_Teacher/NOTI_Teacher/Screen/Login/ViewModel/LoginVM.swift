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
    let apiError = PublishSubject<ErrorResponseModel>()
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
    
    func loginRequest(type: LoginType) {
        let path = "api/teacher/login/\(type.rawValue)"
        let resource = URLResource<TokensResponseModel>(path: path)
        
        AuthAPI.shared.loginRequest(with: resource, token: type.token)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    guard let data = data as? TokensResponseModel else { return }
                    owner.setUserDefaultsToken(data)
                    owner.output.loginResponse.accept(true)
                case .error(let error):
                    guard let error = error as? ErrorResponseModel else { return }
                    owner.apiError.onNext(error)
                case .pathError:
                    print("pathError!!")
                }
            })
            .disposed(by: bag)
    }
    
    /// 토큰 갱신 시 자체 accessToken과 refreshToken을 저장하는 메서드
    func setUserDefaultsToken(_ tokens: TokensResponseModel) {
        UserDefaults.standard.set(tokens.accessToken, forKey: UserDefaults.Keys.accessToken)
        UserDefaults.standard.set(tokens.refreshToken, forKey: UserDefaults.Keys.refreshToken)
    }
}
