//
//  NotificationTVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/18.
//

import UIKit
import SnapKit
import Then

class NotificationTVC: BaseTableViewCell {
    private let statusLabel = UILabel()
        .then {
            $0.text = "[숙제미완료]"
            $0.font = .notoSansKR_Bold(size: 14)
        }
    
    private let messageLabel = UILabel()
        .then {
            $0.text = "중2독해반 - 김노티, 이노티, 강노티 학생이 숙제를 미완료 했습니다."
            $0.font = .notoSansKR_Medium(size: 14)
            $0.setLineBreakMode()
        }
    
    let homeworkLabel = UILabel()
        .then {
            $0.text = "수능특강 p.200-203"
            $0.font = .notoSansKR_Medium(size: 12)
            $0.textColor = .gray02
        }
    
    private let timeLabel = UILabel()
        .then {
            $0.text = "1시간 전"
            $0.font = .notoSansKR_Light(size: 10)
            $0.textColor = .gray02
        }
    
    override func configureView() {
        super.configureView()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0,
                                                                     left: 20,
                                                                     bottom: 0,
                                                                     right: 20))
    }
}

// MARK: - Configure

extension NotificationTVC {
    private func configureContentView() {
        contentView.addSubviews([statusLabel,
                                 messageLabel,
                                 homeworkLabel,
                                 timeLabel])
    }
}

// MARK: - Layout

extension NotificationTVC {
    private func configureLayout() {
        statusLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.leading.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(statusLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        homeworkLabel.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(homeworkLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
}
