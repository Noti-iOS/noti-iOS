//
//  LoginBtn.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/12.
//

import UIKit

class LoginBtn: UIButton {
    var config = UIButton.Configuration.filled()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(image: UIImage?, title: String, backgroundColor: UIColor, textColor: UIColor) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 6

        config.baseBackgroundColor = backgroundColor
        config.baseForegroundColor = textColor
        config.image = image
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        var titleAttributedString = AttributedString.init(title)
        titleAttributedString.font = .notoSansKR_Medium(size: 13)
        
        config.attributedTitle = titleAttributedString
        self.configuration = config
    }
}
