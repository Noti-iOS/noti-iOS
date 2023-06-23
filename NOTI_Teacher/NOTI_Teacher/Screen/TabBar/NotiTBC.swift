//
//  NotiTBC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/29.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class NotiTBC: UITabBarController {
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
}

extension NotiTBC {
    
    private func setTabBar() {
        // 탭바 스타일 설정
        tabBar.backgroundColor = .white
        tabBar.tintColor = .gray03
        tabBar.unselectedItemTintColor = .tagGray
        tabBar.isTranslucent = false
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        
        // 탭 구성
        let homeTab = makeTabVC(vc: HomeNC(),
                                tabBarTitle: "홈",
                                tabBarImage: UIImage(named: "tab_home") ?? UIImage())
        
        let calendarTab = makeTabVC(vc: CalendarVC(),
                                    tabBarTitle: "캘린더",
                                    tabBarImage: UIImage(named: "tab_calendar") ?? UIImage())
        
        let addTab = makeTabVC(vc: HomeVC(),
                               tabBarTitle: "관리",
                               tabBarImage: UIImage(named: "tab_management") ?? UIImage())
        
        let mypageTab = makeTabVC(vc: HomeVC(),
                                  tabBarTitle: "마이페이지",
                                  tabBarImage: UIImage(named: "tab_mypage") ?? UIImage())
        
        let tabs =  [homeTab, calendarTab, addTab, mypageTab]
        
        // VC에 루트로 설정
        self.setViewControllers(tabs, animated: false)
    }
    
    private func makeTabVC(vc: UIViewController,
                           tabBarTitle: String,
                           tabBarImage: UIImage) -> UIViewController {
        let tab = vc
        let tabBarImage = tabBarImage.withRenderingMode(.alwaysTemplate)
        tab.tabBarItem = UITabBarItem(title: tabBarTitle,
                                      image: tabBarImage,
                                      selectedImage: tabBarImage)
        tab.tabBarItem.imageInsets = UIEdgeInsets(top: -0.5,
                                                  left: -0.5,
                                                  bottom: -0.5,
                                                  right: -0.5)
        
        return tab
    }
}
