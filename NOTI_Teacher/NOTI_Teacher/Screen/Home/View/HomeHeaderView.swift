//
//  HomeHeaderView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/30.
//

import UIKit
import SnapKit
import Then

class HomeHeaderView: BaseView {
    private let dateLabel = UILabel()
        .then {
            $0.text = Date.now.toString(separator: .dot)
            $0.font = .notoSansKR_Bold(size: 22)
            $0.textColor = .white
        }
    
    private let dayLabel = UILabel()
        .then {
            $0.text = "(" + Date.now.toString(separator: .dayOnly) + ")"
            $0.font = .notoSansKR_Medium(size: 12)
            $0.textColor = .white
        }
    
    private let messageLabel = UILabel()
        .then {
            $0.text = "Noti에서 수업 관리를 해보세요"
            $0.font = .notoSansKR_Medium(size: 14)
            $0.textColor = .white
        }
    
    override func configureView() {
        super.configureView()
        configureHeader()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
}

// MARK: - Configure

extension HomeHeaderView {
    private func configureHeader() {
        addSubviews([dateLabel,
                     dayLabel,
                     messageLabel])
    }
    
    func setHeaderValue(firstClassTime: String?) {
        messageLabel.text
        = firstClassTime != nil
        ? firstClassTime
        : "오늘은 수업이 없습니다"
    }
}

// MARK: - Layout

extension HomeHeaderView {
    private func configureLayout() {
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(messageLabel.snp.top).offset(-4)
        }
        
        dayLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(4)
            $0.bottom.equalTo(dateLabel.snp.bottom).offset(-4)
        }
        
        messageLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.leading)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}
