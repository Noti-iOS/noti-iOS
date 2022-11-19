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
    
    private var notificationTV = UITableView(frame: .zero)
        .then {
            $0.separatorStyle = .none
            $0.backgroundColor = .systemBackground
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
        bindNaviBarRightBtn()
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
        view.addSubviews([noneNotificationView,
                          notificationTV])
        
        notificationTV.register(NotificationTVC.self,
                                forCellReuseIdentifier: NotificationTVC.className)
        notificationTV.dataSource = self
    }
}

// MARK: - Layout

extension NotificationListVC {
    private func configureLayout() {
        noneNotificationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
        }
        
        notificationTV.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Input

extension NotificationListVC {
    private func bindNaviBarRightBtn() {
        naviBar.rightBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(NotificationSettingVC(),
                                                              animated: true)
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension NotificationListVC {
    
}

extension NotificationListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTVC.className,
                                                       for: indexPath) as? NotificationTVC
        else { fatalError() }
        
        return cell
    }
}
