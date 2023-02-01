//
//  UserDefaults+.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/30.
//

import Foundation

extension UserDefaults {
    enum Keys {
        static var nickname = "nickname"
        static var kakaoAccessToken = "kakaoAccessToken"
        
        // NOTI 토큰
        static var accessToken = "accessToken"
        static var refreshToken = "refreshToken"
    }
}
