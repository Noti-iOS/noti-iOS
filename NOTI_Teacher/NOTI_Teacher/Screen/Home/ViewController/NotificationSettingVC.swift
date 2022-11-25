//
//  NotificationSettingVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/19.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxGesture
import RxSwift

class NotificationSettingVC: BaseViewController {
    private let naviBar = NavigationBar()
    
    private let baseStackView = UIStackView()
        .then {
            $0.axis = .vertical
        }
    
    private var focusStudentsView = ToggleStatusView()
    
    private var incompleteStudentsView = ToggleStatusView()
    
    private var disturbTimeView = ArrowStackComponentView()
    
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
        bindDisturbVC()
    }
    
    override func bindOutput() {
        super.bindOutput()
    }
    
}

// MARK: - Configure

extension NotificationSettingVC {
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self,
                                 naviType: .push,
                                 title: "알림 설정")
        naviBar.configureBackBtn()
    }
    
    private func configureContentView() {
        view.addSubview(baseStackView)
        [focusStudentsView, incompleteStudentsView, disturbTimeView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        baseStackView.addHorizontalSeparators()
        
        focusStudentsView.configureTitle("집중 관리 학생")
        incompleteStudentsView.configureTitle("숙제 미완료 학생")
        disturbTimeView.configureContentView(title: "방해 금지 시간")
        // TODO: - 서버 연결 후 수정
        disturbTimeView.configureMessage("오후 11 : 00 - 오전 10 : 00  알림 미발송")
    }
}

// MARK: - Layout

extension NotificationSettingVC {
    private func configureLayout() {
        baseStackView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        [focusStudentsView, incompleteStudentsView, disturbTimeView].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(72)
            }
        }
    }
}

// MARK: - Input

extension NotificationSettingVC {
    private func bindDisturbVC() {
        disturbTimeView.rx.tapGesture()
            .when(.ended)
            .asDriver(onErrorJustReturn: .init())
            .drive(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(DisturbTimeVC(),
                                                              animated: true)
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension NotificationSettingVC {
    
}
