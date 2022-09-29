//
//  HomeVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxGesture
import RxSwift

class HomeVC: BaseViewController {
    private let naviBar = NavigationBar()
    
    private let headerView = UIView()
        .then {
            $0.backgroundColor = .main
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureContentView()
        configureNaviBar()
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

extension HomeVC {
    private func configureContentView() {
        view.addSubviews([headerView])
    }
    
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self)
        naviBar.configureRightBarBtn(image: UIImage(named: "alarm")!)
    }
}

// MARK: - Layout

extension HomeVC {
    private func configureLayout() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(184)
        }
    }
}

// MARK: - Input

extension HomeVC {
    
}

// MARK: - Output

extension HomeVC {
    
}
