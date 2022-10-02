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
    
    private let nameLabel = UILabel()
        .then {
            $0.text = "T,"
            $0.font = .notoSansKR_Medium(size: 16)
            $0.textColor = .white
        }
    
    private let messageLabel = UILabel()
        .then {
            $0.text = "노티에서 수업 관리를 해보세요!"
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
                     nameLabel,
                     messageLabel])
    }
    
    func setHeaderValue(firstClassTime: String? = nil) {
        // TODO: - 닉네임 연결 후 수정
//        guard let nickname = UserDefaults.standard.string(forKey: UserDefaults.Keys.nickname) else { return }
//        nameLabel.text = nickname + "T,"
        
        messageLabel.text
        = firstClassTime != nil
        ? "오늘의 첫 수업은 \(firstClassTime!)입니다."
        : "오늘은 수업이 없습니다!"
    }
}

// MARK: - Layout

extension HomeHeaderView {
    private func configureLayout() {
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(nameLabel.snp.top).offset(-4)
        }
        
        dayLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(4)
            $0.bottom.equalTo(dateLabel.snp.bottom).offset(-4)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.leading)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        messageLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
            $0.bottom.equalTo(nameLabel.snp.bottom)
        }
    }
}
