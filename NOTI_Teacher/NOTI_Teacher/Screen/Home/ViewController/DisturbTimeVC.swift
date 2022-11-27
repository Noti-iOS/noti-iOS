//
//  DisturbTimeVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/25.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxGesture
import RxSwift

class DisturbTimeVC: BaseViewController {
    private var naviBar = NavigationBar()
    
    private let alarmToggleView = ToggleStatusView()
        .then {
            $0.configureTitle("알림 끄기",
                              .notoSansKR_Medium(size: 14))
            $0.configureStatusMessage(nil)
        }
    
    private let baseStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.line_gray.cgColor
        }
    
    private var startTimeView = TimePickerView()
        .then {
            $0.configureTitle("시작 시간")
            $0.configureButton(time: "-:--",
                               active: false)
        }
    
    private var endTimeView = TimePickerView()
        .then {
            $0.configureTitle("종료 시간")
            $0.configureButton(time: "-:--",
                               active: false)
        }
    
    private let separatorView = UIView()
        .then {
            $0.backgroundColor = .line_gray
        }
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureNaviBar()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
        bindViewActivation()
    }
    
    override func bindOutput() {
        super.bindOutput()
    }
    
}

// MARK: - Configure

extension DisturbTimeVC {
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self,
                                 naviType: .push,
                                 title: "방해 금지 시간 설정")
        naviBar.configureBackBtn()
        naviBar.configureRightBarBtn(title: "완료",
                                     titleColor: .main)
    }
    
    private func configureContentView() {
        view.addSubviews([alarmToggleView,
                          baseStackView])
        [startTimeView, separatorView, endTimeView].forEach {
            baseStackView.addArrangedSubview($0)
        }
    }
}

// MARK: - Layout

extension DisturbTimeVC {
    private func configureLayout() {
        alarmToggleView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(64)
        }
        
        baseStackView.snp.makeConstraints {
            $0.top.equalTo(alarmToggleView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
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

// MARK: - Input

extension DisturbTimeVC {
    private func bindViewActivation() {
        alarmToggleView.toggleBtn.rx.isOn
            .asDriver()
            .drive(onNext: {[weak self] isOn in
                guard let self = self else { return }
                // TODO: - 비활성화, 활성화 디자인 적용
                print(isOn)
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension DisturbTimeVC {
    
}
