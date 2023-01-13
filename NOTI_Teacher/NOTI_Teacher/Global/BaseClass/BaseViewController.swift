//
//  BaseViewController.swift
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

class BaseViewController: UIViewController {
    
    // MARK: Properties
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let keyboardWillShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
    let keyboardWillHide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        layoutView()
        bindRx()
        hideKeyboard()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func layoutView() {}
    
    func bindRx() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {}
    
    func bindOutput() {}
    
    /// rootViewController를 메인화면(NotiTBC)으로 변경하는 메서드
    func setTBCtoRootVC() {
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
        ad.window?.rootViewController = NotiTBC()
    }
    
    /// fatalError시 로그인 화면으로 이동하는 메서드
    func setLogintoRootVC() {
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
        ad.window?.rootViewController = LoginVC()
    }
}
