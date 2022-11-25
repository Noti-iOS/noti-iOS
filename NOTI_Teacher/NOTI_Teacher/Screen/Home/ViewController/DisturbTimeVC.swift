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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureNaviBar()
    }
    
    override func layoutView() {
        super.layoutView()
    }
    
    override func bindInput() {
        super.bindInput()
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
}

// MARK: - Layout

extension DisturbTimeVC {
    
}

// MARK: - Input

extension DisturbTimeVC {
    
}

// MARK: - Output

extension DisturbTimeVC {
    
}
