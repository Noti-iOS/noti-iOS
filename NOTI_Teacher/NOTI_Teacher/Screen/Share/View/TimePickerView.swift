//
//  TimePickerView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/12/09.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class TimePickerView: BaseView {
    private let baseStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lineGray.cgColor
        }
    
    private var startTimeView = TimePickerContentView()
    
    private var endTimeView = TimePickerContentView()
    
    private let separatorView = UIView()
        .then {
            $0.backgroundColor = .lineGray
        }
    
    private let bag = DisposeBag()
    
    init(startTitle: String, endTitle: String, pickerMode: UIDatePicker.Mode) {
        super.init(frame: .zero)
        startTimeView.configureTitle(startTitle)
        startTimeView.configurePicker(mode: pickerMode)
        endTimeView.configureTitle(endTitle)
        endTimeView.configurePicker(mode: pickerMode)
        
        if pickerMode == .dateAndTime || pickerMode == .date {
            bindStartEndTime()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension TimePickerView {
    private func configureContentView() {
        addSubview(baseStackView)
        [startTimeView, separatorView, endTimeView].forEach {
            baseStackView.addArrangedSubview($0)
        }
    }
    
    /// 항상 종료 시간이 시작 시간보다 크거나 같도록 연결하는 메서드
    private func bindStartEndTime() {
        startTimeView.pickerButton.rx.date.changed
            .asDriver()
            .drive(onNext: {[weak self] time in
                guard let self = self else { return }
                if self.endTimeView.pickerButton.date < time {
                    self.endTimeView.pickerButton.date = time
                }
            })
            .disposed(by: bag)
        
        endTimeView.pickerButton.rx.date.changed
            .asDriver()
            .drive(onNext: {[weak self] time in
                guard let self = self else { return }
                if self.startTimeView.pickerButton.date > time {
                    self.startTimeView.pickerButton.date = time
                }
            })
            .disposed(by: bag)
    }
}

// MARK: - Layout

extension TimePickerView {
    private func configureLayout() {
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [startTimeView, endTimeView].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(62)
            }
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        baseStackView.isLayoutMarginsRelativeArrangement = true
        baseStackView.layoutMargins = UIEdgeInsets(top: .zero,
                                                   left: 20,
                                                   bottom: .zero,
                                                   right: 20)
    }
}
