//
//  NotificationListVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/18.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxGesture
import RxSwift

class NotificationListVC: BaseViewController {
    private let naviBar = NavigationBar()
    
    private let noneNotificationView = NoneNotificationView()
    
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
    }
    
    override func bindOutput() {
        super.bindOutput()
    }
    
}

// MARK: - Configure

extension NotificationListVC {
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self,
                                 naviType: .push,
                                 title: "알림")
        naviBar.configureBackBtn()
        naviBar.configureRightBarBtn(image: UIImage(named: "setting")!)
    }
    
    private func configureContentView() {
        view.addSubviews([noneNotificationView])
    }
}

// MARK: - Layout

extension NotificationListVC {
    private func configureLayout() {
        noneNotificationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
        }
    }
}

// MARK: - Input

extension NotificationListVC {
    
}

// MARK: - Output

extension NotificationListVC {
    
}
