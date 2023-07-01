//
//  CalendarHeaderView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/26.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class CalendarHeaderView: BaseView {
    let dateLabel = UILabel()
        .then {
            $0.font = .notoSansKR_Medium(size: 20)
            $0.textColor = .label
            $0.textAlignment = .center
        }
    
    let prevMonthBtn = UIButton()
        .then {
            $0.setImage(.arrowLeft.withTintColor(.label, renderingMode: .alwaysOriginal), for: .normal)
        }
    
    let nextMonthBtn = UIButton()
        .then {
            $0.setImage(.arrowRight.withTintColor(.label, renderingMode: .alwaysOriginal), for: .normal)
        }
    
    override func configureView() {
        super.configureView()
        configureContentView()
        configureTitleDate(.now)
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
}

// MARK: - Configure

extension CalendarHeaderView {
    private func configureContentView() {
        addSubviews([dateLabel,
                     prevMonthBtn,
                     nextMonthBtn])
    }
    
    private func configureTitleDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateType.yearMonth.dateFormatter
        dateLabel.text = "\(dateFormatter.string(from: date))"
    }
}

// MARK: - Layout

extension CalendarHeaderView {
    private func configureLayout() {
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        nextMonthBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(28)
        }
        
        prevMonthBtn.snp.makeConstraints {
            $0.trailing.equalTo(nextMonthBtn.snp.leading).offset(-24)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(28)
        }
    }
}
