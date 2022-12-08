//
//  LoadingView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import UIKit
import SnapKit
import Then

class LoadingView: BaseView {
    private var indicator = UIActivityIndicatorView(frame: CGRect(x: 0,
                                                                  y: 0, width: 50,
                                                                  height: 50))

    override func configureView() {
        backgroundColor = .black.withAlphaComponent(0.3)
        addSubview(indicator)
    }
    
    override func layoutView() {
        indicator.center = center
        indicator.startAnimating()
    }
}
