//
//  TimePickerView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/12/09.
//

import UIKit
import SnapKit
import Then

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
    
    init(startTitle: String, endTitle: String, startPickerMode: UIDatePicker.Mode, endPickerMode: UIDatePicker.Mode) {
        super.init(frame: .zero)
        startTimeView.configureTitle(startTitle)
        startTimeView.configurePicker(mode: startPickerMode)
        endTimeView.configureTitle(endTitle)
        endTimeView.configurePicker(mode: endPickerMode)
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
