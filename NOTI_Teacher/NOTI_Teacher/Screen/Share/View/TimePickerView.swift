//
//  TimePickerView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class TimePickerView: BaseView {
    private var timeTitle = UILabel()
        .then {
            $0.textColor = .gray01
            $0.font = .notoSansKR_Medium(size: 14)
        }
    
    private var pickerButton = UIDatePicker()
        .then {
            $0.locale = Locale(identifier: "ko_KR")
            $0.tintColor = .main
        }
    
    private let bag = DisposeBag()
    
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

extension TimePickerView {
    private func configureContentView() {
        addSubviews([timeTitle,
                     pickerButton])
        
    }
    
    func configureTitle(_ title: String) {
        timeTitle.text = title
    }
    
    func configurePicker(mode: UIDatePicker.Mode) {
        pickerButton.datePickerMode = mode
        configurePickerWidth(mode: mode)
    }
    
    /// picker의 isUserInteractionEnabled 상태를 지정하는 메서드
    func setPickerActiveStatus(_ active: Bool) {
        pickerButton.isUserInteractionEnabled = active
    }
}

// MARK: - Layout

extension TimePickerView {
    private func configureLayout() {
        timeTitle.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        pickerButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    
    private func configurePickerWidth(mode: UIDatePicker.Mode) {
        pickerButton.snp.makeConstraints {
            $0.width.equalTo(mode == .time ? 81 : 230)
        }
    }
}
