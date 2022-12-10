//
//  TimePickerContentView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/25.
//

import UIKit
import SnapKit
import Then

class TimePickerContentView: BaseView {
    private var timeTitle = UILabel()
        .then {
            $0.textColor = .gray01
            $0.font = .notoSansKR_Medium(size: 14)
        }
    
    var pickerButton = UIDatePicker()
        .then {
            $0.locale = Locale(identifier: "ko_KR")
            $0.tintColor = .main
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

extension TimePickerContentView {
    private func configureContentView() {
        addSubviews([timeTitle,
                     pickerButton])
    }
    
    func configureTitle(_ title: String) {
        timeTitle.text = title
    }
    
    func configurePicker(mode: UIDatePicker.Mode) {
        pickerButton.datePickerMode = mode
    }
}

// MARK: - Layout

extension TimePickerContentView {
    private func configureLayout() {
        timeTitle.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        pickerButton.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(timeTitle.snp.trailing).offset(4)
            $0.centerY.trailing.equalToSuperview()
        }
    }
}
