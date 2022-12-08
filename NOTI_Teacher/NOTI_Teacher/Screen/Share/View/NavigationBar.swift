//
//  NavigationBar.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import UIKit
import SnapKit
import Then

class NavigationBar: BaseView {
    private var naviType: NaviType!
    
    private var targetVC: UIViewController!

    private let barHeight = 48
    private let buttonSize: Float = 38

    private var title = UILabel()
        .then {
            $0.font = .notoSansKR_Bold(size: 16)
            $0.textAlignment = .center
        }
       
    private var backBtn = UIButton()
        .then {
            $0.tintColor = .label
        }
    
    var rightBtn = UIButton()
        .then {
            $0.tintColor = .label
        }
    
    override func configureView() {
        super.configureView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
}

// MARK: - Configure
extension NavigationBar {
    /// naviBar을 view에 추가하고 title을 지정하는 함수
    func configureNaviBar(targetVC: UIViewController,
                          naviType: NaviType = .base,
                          title: String = "") {
        self.targetVC = targetVC
        self.naviType = naviType
        self.title.text = title
        
        targetVC.view.addSubview(self)
        self.snp.makeConstraints {
            $0.height.equalTo(barHeight)
            $0.top.leading.trailing.equalTo(targetVC.view.safeAreaLayoutGuide)
        }
    }
    
    /// naviBar의 backBtn을 지정하는 메서드
    /// push는 왼쪽, present는 오른쪽에 뒤로가기 / 닫기 버튼이 추가되도록 구현
    func configureBackBtn() {
        switch naviType {
        case .base, .none:
            return
        case .push:
            leftBtnLayout()
            backBtn.setImage(naviType.backBtnImage,
                             for: .normal)
            backBtn.addTarget(targetVC,
                              action: #selector(targetVC.popVC),
                              for: .touchUpInside)
        case .present:
            rightBtnLayout()
            rightBtn.setImage(naviType.backBtnImage,
                              for: .normal)
            rightBtn.addTarget(targetVC,
                               action: #selector(targetVC.dismissVC),
                               for: .touchUpInside)
        }
    }
    
    /// naviBar의 우측 버튼(이미지)을 추가하는 함수입니다.
    func configureRightBarBtn(image: UIImage) {
        rightBtn.setImage(image, for: .normal)
        rightBtnLayout()
        rightBtnWidth(buttonSize)
    }
    
    /// naviBar의 우측 버튼(글자)을 추가하는 함수입니다.
    func configureRightBarBtn(title: String,
                              titleColor: UIColor = .black) {
        rightBtnLayout()
        rightBtn.setTitle(title, for: .normal)
        rightBtn.setTitleColor(titleColor, for: .normal)
        rightBtn.titleLabel?.font = .notoSansKR_Bold(size: 14)
        rightBtn.contentEdgeInsets = UIEdgeInsets(top: 0,
                                                  left: 10,
                                                  bottom: 0,
                                                  right: 10)
    }
}


// MARK: - Layout
extension NavigationBar {
    private func configureLayout() {
        self.addSubview(title)
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func rightBtnLayout() {
        self.addSubview(rightBtn)
        rightBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(buttonSize)
        }
    }
    
    private func rightBtnWidth(_ width: Float) {
        rightBtn.snp.makeConstraints {
            $0.width.equalTo(width)
        }
    }
    
    private func leftBtnLayout() {
        self.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.width.height.equalTo(barHeight)
        }
    }
}
