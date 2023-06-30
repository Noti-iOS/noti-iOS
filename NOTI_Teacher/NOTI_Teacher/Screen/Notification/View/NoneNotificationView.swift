//
//  NoneNotificationView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/18.
//

import UIKit
import SnapKit
import Then

class NoneNotificationView: BaseView {
    private let noneImageView = UIImageView()
        .then {
            $0.image = UIImage(named: "bell_off")
        }
    
    private let noneMessage = UILabel()
        .then {
            $0.text = "새로운 알림이 없습니다."
            $0.textColor = .gray01
            $0.font = .notoSansKR_Medium(size: 16)
        }
    
    override func configureView() {
        super.configureView()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
}

// MARK: - Configure

extension NoneNotificationView {
    private func configureContentView() {
        addSubviews([noneImageView,
                     noneMessage])
    }
}

// MARK: - Layout

extension NoneNotificationView {
    private func configureLayout() {
        noneImageView.snp.makeConstraints {
            $0.centerX.top.equalToSuperview()
            $0.width.height.equalTo(106)
        }
        
        noneMessage.snp.makeConstraints {
            $0.top.equalTo(noneImageView.snp.bottom).offset(12)
            $0.centerX.bottom.equalToSuperview()
        }
    }
}
