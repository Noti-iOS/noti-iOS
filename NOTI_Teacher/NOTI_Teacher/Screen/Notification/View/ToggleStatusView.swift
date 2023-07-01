//
//  ToggleStatusView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/19.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class ToggleStatusView: BaseView {
    private var baseStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 4
        }
    
    private var statusTitle = UILabel()
        .then {
            $0.font = .notoSansKR_Bold(size: 14)
        }
    
    private var statusLabel = UILabel()
        .then {
            $0.font = .notoSansKR_Light(size: 12)
            $0.textColor = .gray02
        }
    
    var toggleBtn = UISwitch()
        .then {
            $0.onTintColor = .main
            $0.tintColor = .red
        }
    
    private let bag = DisposeBag()
    
    override func configureView() {
        super.configureView()
        addViews()
        bindToggle()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
}

// MARK: - Configure

extension ToggleStatusView {
    private func addViews() {
        addSubviews([baseStackView,
                     toggleBtn])
        [statusTitle, statusLabel].forEach {
            baseStackView.addArrangedSubview($0)
        }
    }
    
    func configureTitle(_ title: String,
                        _ font: UIFont = .notoSansKR_Bold(size: 14)) {
        statusTitle.text = title
        statusTitle.font = font
    }
    
    func configureStatusMessage(_ text: String?) {
        statusLabel.text = text
    }
}

// MARK: - Layout

extension ToggleStatusView {
    private func configureLayout() {
        baseStackView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        toggleBtn.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
    }
}

// MARK: - Input

extension ToggleStatusView {
    private func bindToggle() {
        if statusLabel.text == nil { return }
        toggleBtn.rx.isOn
            .asDriver()
            .drive(onNext: {[weak self] status in
                guard let self = self else { return }
                self.statusLabel.text = status ? "앱 푸시" : "OFF"
            })
            .disposed(by: bag)
    }
}
