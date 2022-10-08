//
//  BaseCollectionViewCell.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/02.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {}
    
    func layoutView() {}
}
