//
//  UIImage+.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/07/01.
//

import UIKit

extension UIImage {
    /// NOTI의 로고 NoTi
    @nonobjc class var logo: UIImage {
        return UIImage(named: "Logo")!
    }
    
    /// NOTI 학생의 기본 썸네일 이미지를 반환하는 변수
    @nonobjc class var defaultProfileImage: UIImage {
        return UIImage(named: "defaultProfileImage")!
    }
    
    /// +
    @nonobjc class var add: UIImage {
        return UIImage(named: "add")!
    }
    
    // MARK: - Naviagtion Item
    
    /// 설정
    @nonobjc class var setting: UIImage {
        return UIImage(named: "setting")!
    }
    
    /// 검색
    @nonobjc class var search: UIImage {
        return UIImage(named: "search")!
    }
    
    /// X
    @nonobjc class var pop: UIImage {
        return UIImage(named: "pop")!
    }
    
    /// <
    @nonobjc class var dismiss: UIImage {
        return UIImage(named: "dismiss")!
    }
    
    // MARK: - Arrow
    /// >
    @nonobjc class var arrowRight: UIImage {
        return UIImage(named: "arrow_right")!
    }
    
    /// <
    @nonobjc class var arrowLeft: UIImage {
        return UIImage(named: "arrow_left")!
    }
    
    /// ^
    @nonobjc class var arrowUp: UIImage {
        return UIImage(named: "arrow_up")!
    }
    
    /// v
    @nonobjc class var arrowDown: UIImage {
        return UIImage(named: "arrow_down")!
    }
    
    // MARK: - Login
    /// 카카오톡 로그인 아이콘
    @nonobjc class var kakaoIcon: UIImage {
        return UIImage(named: "kakaoIcon")!
    }
    
    /// 애플 로그인 아이콘
    @nonobjc class var appleIcon: UIImage {
        return UIImage(named: "appleIcon")!
    }
    
    // MARK: - Tab
    @nonobjc class var tabHome: UIImage {
        return UIImage(named: "tab_home")!
    }
    
    @nonobjc class var tabCalendar: UIImage {
        return UIImage(named: "tab_calendar")!
    }
    
    @nonobjc class var tabManagement: UIImage {
        return UIImage(named: "tab_management")!
    }
    
    @nonobjc class var tabMypage: UIImage {
        return UIImage(named: "tab_mypage")!
    }
}
