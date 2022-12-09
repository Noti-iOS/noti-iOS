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
    
    private let timePickerView = TimePickerView(startTitle: "시작 시간",
                                                endTitle: "종료 시간",
                                                startPickerMode: .time,
                                                endPickerMode: .time)
    
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
                          timePickerView])
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
        
        timePickerView.snp.makeConstraints {
            $0.top.equalTo(alarmToggleView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        timePickerView.sizeToFit()
    }
}

// MARK: - Input

extension DisturbTimeVC {
    private func bindViewActivation() {
        alarmToggleView.toggleBtn.rx.isOn
            .asDriver()
            .drive(onNext: {[weak self] isOn in
                guard let self = self else { return }
                self.timePickerView.isUserInteractionEnabled = isOn
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension DisturbTimeVC {
    
}
