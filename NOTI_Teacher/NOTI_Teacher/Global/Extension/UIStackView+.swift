//
//  UIStackView+.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/21.
//

import UIKit

extension UIStackView {
    /// stackView에 세로 구분선을 추가하는 함수
    func addVerticalSeparators(color : UIColor = .line_gray,
                               width: CGFloat = 1,
                               multiplier: CGFloat = 1) {
        var i = self.arrangedSubviews.count - 1
        while i > 0 {
            let separator = createVerticalSeparator(color: color, width: width)
            insertArrangedSubview(separator, at: i)
            separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
            i -= 1
        }
    }

    /// vertical separator을 반환하는 함수
    private func createVerticalSeparator(color: UIColor,
                                         width: CGFloat) -> UIView {
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: width).isActive = true
        separator.backgroundColor = color
        return separator
    }
    
    /// stackView에 가로 구분선을 추가하는 함수
    func addHorizontalSeparators(color : UIColor = .line_gray,
                                 height: CGFloat = 1,
                                 multiplier: CGFloat = 1) {
        var i = self.arrangedSubviews.count
        while i > 0 {
            let separator = createHorizontalSeparator(color: color, height: height)
            insertArrangedSubview(separator, at: i)
            separator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
            i -= 1
        }
    }

    /// horizontal separator을 반환하는 함수
    private func createHorizontalSeparator(color: UIColor,
                                           height: CGFloat) -> UIView {
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: height).isActive = true
        separator.backgroundColor = color
        return separator
    }
}
