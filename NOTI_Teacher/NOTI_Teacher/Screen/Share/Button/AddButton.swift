//
//  AddButton.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/02/18.
//

import UIKit

class AddButton: UIButton {
    var config = UIButton.Configuration.plain()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        layer.borderColor = UIColor.lineGray.cgColor
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .notoSansKR_Medium(size: 14)
            return outgoing
        }
        
        config.imagePadding = 8
        config.baseForegroundColor = .gray00
        configuration = config

        setImage(UIImage(named: "add"), for: .normal)
        layer.cornerRadius = 5
        layer.borderColor = UIColor.lineGray.cgColor
        layer.borderWidth = 1        
    }
}
