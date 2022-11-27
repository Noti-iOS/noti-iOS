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
    
    var pickerButton = UIButton()
        .then {
            $0.layer.cornerRadius = 5
        }
    
    var config = UIButton.Configuration.filled()
    
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
        // TODO: - 컬러셋 추가 후 수정
        config.baseBackgroundColor = active ? .gray : .line_gray
        config.baseForegroundColor = active ? .main : .systemGreen
        
        var titleAttributedString = AttributedString.init(time)
        titleAttributedString.font = .notoSansKR_Medium(size: 14)
        
        config.attributedTitle = titleAttributedString
        
        pickerButton.configuration = config
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
                // TODO: - TimePicker 연결
                print("picker Open")
            })
            .disposed(by: bag)
    }
}
