//
//  FilledButton.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/12/08.
//

import UIKit

class FilledButton: UIButton {
    var config = UIButton.Configuration.filled()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
           var outgoing = incoming
           outgoing.font = .notoSansKR_Medium(size: 14)
           return outgoing
        }
        
        configuration = config
    }
    
    override open var isSelected: Bool {
        didSet {
            config.baseBackgroundColor = isSelected ? .sub01 : .bgGray
            config.baseForegroundColor = isSelected ? .main : .tagGray
            configuration = config
        }
    }
}

