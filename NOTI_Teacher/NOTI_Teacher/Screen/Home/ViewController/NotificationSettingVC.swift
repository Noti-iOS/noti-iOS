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

extension NotificationSettingVC {
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self,
                                 naviType: .push,
                                 title: "알림 설정")
        naviBar.configureBackBtn()
    }
}

// MARK: - Layout

extension NotificationSettingVC {
    
}

// MARK: - Input

extension NotificationSettingVC {
    
}

// MARK: - Output

extension NotificationSettingVC {
    
}
