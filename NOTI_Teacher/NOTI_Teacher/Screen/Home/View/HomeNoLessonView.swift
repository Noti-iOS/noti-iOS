//
//  HomeNoLessonView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/02/17.
//

import UIKit
import SnapKit
import Then

class HomeNoLessonView: BaseView {
    var titleLabel = UILabel()
        .then {
            $0.font = .notoSansKR_Bold(size: 20)
            $0.textColor = .gray00
            $0.textAlignment = .center
        }
    
    var messageLabel = UILabel()
        .then {
            $0.font = .notoSansKR_Medium(size: 12)
            $0.textColor = .gray01
            $0.textAlignment = .center
        }
    
    var addBtn = AddButton()
        .then {
            $0.setTitle("수업 등록하기", for: .normal)
        }
    
    override func configureView() {
        super.configureView()
        addSubviews([titleLabel,
                     messageLabel,
                     addBtn])
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
}

// MARK: - Configure

extension HomeNoLessonView {
    /// 타이틀, 메세지, 버튼 타이틀을 지정하는 메서드
    func configureContentView(title: String, message: String, addBtnTitle: String) {
        titleLabel.text = title
        messageLabel.text = message
        addBtn.setTitle(addBtnTitle, for: .normal)
    }
}

// MARK: - Layout

extension HomeNoLessonView {
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        addBtn.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview()
        }
    }
}
