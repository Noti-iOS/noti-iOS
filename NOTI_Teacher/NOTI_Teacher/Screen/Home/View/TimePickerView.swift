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
    var timeTitle = UILabel()
        .then {
            $0.textColor = .gray01
            $0.font = .notoSansKR_Medium(size: 14)
        }
    
    var pickerButton = FilledButton()
    
    private let bag = DisposeBag()
    
    override func configureView() {
        super.configureView()
        configureContentView()
        bindPicker()
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
    
    func configureButton(time: String, active: Bool) {
        pickerButton.setTitle(time, for: .normal)
        pickerButton.isSelected = active
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
}

extension TimePickerView {
    private func bindPicker() {
        pickerButton.rx.tap
            .asDriver()
            .drive(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.pickerButton.isSelected.toggle()
                // TODO: - TimePicker 연결
            })
            .disposed(by: bag)
    }
}
