//
//  LoginType.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/01/11.
//

import Foundation

enum LoginType: String {
    case kakao = "kakao"
    case apple = "apple"
}

extension LoginType {
    // TODO: - 토큰 없는 경우 fatalError 대신 로그인 화면으로 이동
    var token: String {
        switch self {
        case .kakao:
            guard let token = UserDefaults.standard.string(forKey: UserDefaults.Keys.kakaoAccessToken)
            else { fatalError() }
            return token
        case .apple:
            guard let token = UserDefaults.standard.string(forKey: UserDefaults.Keys.appleToken)
            else { fatalError() }
            return token
        }
    }
}
