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

extension NotificationListVC {
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self,
                                 naviType: .push,
                                 title: "알림")
        naviBar.configureBackBtn()
        naviBar.configureRightBarBtn(image: UIImage(named: "setting")!)
    }
}

// MARK: - Layout

extension NotificationListVC {
    
}

// MARK: - Input

extension NotificationListVC {
    
}

// MARK: - Output

extension NotificationListVC {
    
}
