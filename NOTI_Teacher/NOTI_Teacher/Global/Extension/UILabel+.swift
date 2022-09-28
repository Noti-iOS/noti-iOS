//
//  UILabel+.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import UIKit

extension UILabel {
    /// 여러 줄 보기
    func setLineBreakMode() {
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        lineBreakMode = .byCharWrapping
    }
}
